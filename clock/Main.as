package
{
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    
    public class Clock2 extends Sprite
    {
        private var parts:Array;
        private var numbers:Array;
        private var date:Date;
        private var hour1:Sprite;
        private var hour2:Sprite;
        private var minutes1:Sprite;
        private var minutes2:Sprite;
        private var second1:Sprite;
        private var second2:Sprite;
        private var clockWidth:Number;
        private var left_point:Number;
        private var dots:Sprite;
        private var bg_color:Number;
        private var color:Number;
        public function Clock2()
        {
            //上,左上,右上,真ん中,左下,右下,下
            parts=[
                [5,0,8,5,20,5,23,0,5,0],
                [3,0,0,5,0,30,6,27,6,5,3,0],
                [25,0,22,5,22,27,28,30,28,5,25,0],
                [0,32,6,29,22,29,28,32,22,35,6,35,0,32],
                [0,34,0,59,3,64,6,59,6,37,0,34],
                [28,34,28,59,25,64,22,59,22,37,28,34],
                [5,64,8,59,20,59,23,64,5,64]
            ];
            //0123456789
            numbers=[
                [0,1,2,4,5,6],
                [2,5],
                [0,2,3,4,6],
                [0,2,3,5,6],
                [1,2,3,5],
                [0,1,3,5,6],
                [0,1,3,4,5,6],
                [0,1,2,5],
                [0,1,2,3,4,5,6],
                [0,1,2,3,5,6],
            ];
            bg_color=0x8FBC8F;
            color=0x000000;
            addEventListener(Event.ENTER_FRAME,_enterFrame);
            hour1=new Sprite();
            hour2=new Sprite();
            minutes1=new Sprite();
            minutes2=new Sprite();
            second1=new Sprite();
            second2=new Sprite();
            dots=new Sprite();
            clockWidth=203;
            trace(28*6+50);
            left_point=stage.stageWidth/2-218/2;
            hour1.x=left_point;
            hour2.x=left_point+28+10;
            dots.graphics.beginFill(color,0.7);
            dots.graphics.drawCircle(left_point+28+28+10+10,20,3);
            dots.graphics.drawCircle(left_point+28+28+10+10,44,3);
            minutes1.x=left_point+28+28+10+20;
            minutes2.x=left_point+28+28+28+10+10+20;
            dots.graphics.drawCircle(left_point+28+28+28+28+10+10+20+10,20,3);
            dots.graphics.drawCircle(left_point+28+28+28+28+10+10+20+10,44,3);
            dots.graphics.endFill();
            second1.x=left_point+28+28+28+28+10+10+20+20;
            second2.x=left_point+28+28+28+28+28+10+10+10+20+20;
            var f:DropShadowFilter=new DropShadowFilter(2,45,0,0.4,3,3);
            hour1.y=hour2.y=minutes1.y=minutes2.y=second1.y=second2.y=dots.y=30;
            addChild(hour1);
            addChild(hour2);
            addChild(minutes1);
            addChild(minutes2);
            addChild(second1);
            addChild(second2);
            addChild(dots);
            hour1.filters=hour2.filters=minutes1.filters=minutes2.filters=second1.filters=second2.filters=dots.filters=[f];
            this.graphics.beginFill(bg_color);
            this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
            this.graphics.endFill();
        }
        private function _enterFrame(event:Event):void{
            date=new Date();
            if(String(date.hours).length>1){
                draw_number(hour1,Number(String(date.hours).charAt(0)),color);
                draw_number(hour2,Number(String(date.hours).charAt(1)),color);
            }else{
                draw_number(hour1,0,color);
                draw_number(hour2,Number(date.hours),color);
            }
            if(String(date.minutes).length>1){
                draw_number(minutes1,Number(String(date.minutes).charAt(0)),color);
                draw_number(minutes2,Number(String(date.minutes).charAt(1)),color);
            }else{
                draw_number(minutes1,0,color);
                draw_number(minutes2,Number(date.minutes),color);
            }
            if(String(date.seconds).length>1){
                draw_number(second1,Number(String(date.seconds).charAt(0)),color);
                draw_number(second2,Number(String(date.seconds).charAt(1)),color);
            }else{
                draw_number(second1,0,color);
                draw_number(second2,Number(date.seconds),color)
            }
        }
        private function draw_number(sprite:Sprite,number:int,color:Number):void{
            sprite.graphics.clear();
            for(var i:int;i<parts.length;i++){
                var b:Boolean=false;
                for(var n:int=0;n<numbers[number].length;n++){
                    if(numbers[number][n]==i){
                        b=true;
                    }
                }
                if(b){
                    sprite.graphics.beginFill(color,0.7);
                }else{
                    sprite.graphics.beginFill(0,0.1);
                }
                for(var j:int=0;j<parts[i].length;j+=2){
                    if(j!==0){
                        sprite.graphics.lineTo(parts[i][j],parts[i][j+1]);
                    }else{
                        sprite.graphics.moveTo(parts[i][j],parts[i][j+1]);
                    }
                }
                sprite.graphics.endFill();
            }
        }
    }
}