package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    public class Suitori extends Sprite
    {
        private var line_data:Array;
        private var move_speed_data:Array;
        private var move_data:Array;
        private var mouse_down:Boolean;
        private var target_y:Number;
        private var target_x:Number;
        private var speed:Number=0;
        private var cnt:int;
        private var suck_btn:Sprite;
        private var _sucking:Boolean;
        public function Suitori()
        {
            this.graphics.lineStyle(3);
            
            suck_btn=btn("吸込み");
            addChild(suck_btn);
            suck_btn.x=stage.stageWidth-suck_btn.width;
            
            
            line_data=new Array();
            move_data=new Array();
            move_speed_data=new Array();
            move_data=new Array();
            stage.addEventListener(MouseEvent.MOUSE_DOWN,_mouseDown);
            stage.addEventListener(MouseEvent.MOUSE_MOVE,_mouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP,_mouseUp);
            suck_btn.addEventListener(MouseEvent.CLICK,sucking_event);
            //吸引開始
            //sucking(mouseX,mouseY);
        }
        private function sucking_event(event:MouseEvent):void{
            if(!_sucking){
            target_x=stage.stageWidth;
            target_y=0;
            sucking(target_x,target_y);
            _sucking=true;
            }
        }
        private function btn(label:String):Sprite{
            var spr:Sprite=new Sprite();
            var label_txt:TextField=new TextField();
            label_txt.selectable=false;
            label_txt.mouseEnabled=false;
            label_txt.text=label;
            label_txt.autoSize=TextFieldAutoSize.LEFT;
            spr.addChild(label_txt);
            spr.graphics.beginFill(0xcccccc);
            spr.graphics.drawRect(0,0,label_txt.width,label_txt.height);
            spr.graphics.endFill();
            return spr;
        }
        private function _mouseDown(event:MouseEvent):void{
            if(!_sucking){
            this.graphics.moveTo(mouseX,mouseY);
            line_data.push("s");
            line_data.push([mouseX,mouseY]);
            move_data.push([mouseX,mouseY]);
            move_data.push([mouseX,mouseY]);
            mouse_down=true;
            }
        }
        private function _mouseMove(event:MouseEvent):void{
            if(mouse_down){
                this.graphics.lineTo(mouseX,mouseY);
                line_data.push([mouseX,mouseY]);
                move_data.push([mouseX,mouseY]);
            }
        }
        private function _mouseUp(event:MouseEvent):void{
            mouse_down=false;
        }
        private function sucking(target_x:Number,target_y:Number):void{
            for(var i:int;i<line_data.length;i++){
                if(line_data[i]!=="s"){
                    move_speed_data.push([Math.cos(Math.atan2(target_y-line_data[i][1],target_x-line_data[i][0]))*speed,Math.sin(Math.atan2(target_y-line_data[i][1],target_x-line_data[i][0]))*speed]);
                }
            }
            addEventListener(Event.ENTER_FRAME,_enterFrame);
        }
        private function _enterFrame(event:Event):void{
            cnt=0;
            for(var i:int;i<line_data.length;i++){
                if(line_data[i]!=="s"){
                    move_speed_data[i]=[Math.cos(Math.atan2(target_y-line_data[i][1],target_x-line_data[i][0]))*speed,Math.sin(Math.atan2(target_y-line_data[i][1],target_x-line_data[i][0]))*speed]
                    if(Math.abs(move_data[i][0]-target_x)+Math.abs(move_data[i][1]-target_y)>speed){
                        move_data[i][0]+=move_speed_data[i][0];
                        move_data[i][1]+=move_speed_data[i][1];
                    }else{
                        cnt++;
                    }
                }else{
                    cnt++;
                }
            }
            speed+=0.3;
            this.graphics.clear();
            this.graphics.lineStyle(3);
            for(i=0;i<line_data.length;i++){
                if(line_data[i]=="s"){
                    i++;
                    this.graphics.moveTo(move_data[i][0],move_data[i][1]);
                }else{
                    this.graphics.lineTo(move_data[i][0],move_data[i][1]);
                }
            }
            if(cnt==line_data.length){
                cnt=0;
                removeEventListener(Event.ENTER_FRAME,_enterFrame);
                move_data=[];
                line_data=[];
                move_speed_data=[];
                speed=0;
                _sucking=false;
            }
        }
    }
}