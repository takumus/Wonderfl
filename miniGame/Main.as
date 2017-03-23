package
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;

    public class Test extends Sprite
    {
        //落ちる物
        private var fall_obj:Sprite;
        //プレイヤー
        private var player:Sprite;
        //地面
        private var ground:Shape;
        //上から落ちる地面（ハンマーにした理由はそれしか思いつかなかったからです）
        private var hunmer:Shape;
        //にげられる空間
        private var space:Shape;
        //空間のある位置のid
        private var space_pos:int;
        //区切り
        private var solid:int;
        //間隔
        private var interval:Number;
        //プレーヤーの存在できる位置
        private var positions:Array;
        //プレイヤーの現在いる位置のid
        private var ppos:int;
        //落ちる速度
        private var speed:Number;
        //一回落ちたかどうか（trueになると上に上がる）
        private var ok:Boolean;
        //スコアを表示
        private var score:TextField;
        public function Test()
        {
            //区切り（都合上+1する）
            solid=3+1;
            //区切りから、間隔を算出
            interval=(stage.stageWidth)/solid;
            positions=new Array();
            //初期スピード
            speed=7;
            //初期の位置
            ppos=0;
            //スコアの初期化
            score=new TextField();
            score.x=stage.stageWidth-100;
            score.y=0;
            score.text=String(0);
            //プレイヤーのポジションを格納
            for(var i:int=1;i<solid;i++){
                positions.push(interval*i);
            }
            //それぞれ
            _makeHunmer();
            _makeSpace();
            _makeGround();
            _makePlayer();
            addChild(score);
            //ハンマー＆スペースの初期位置
            hunmer.y=-(stage.stageHeight-170);
            space.y=-(stage.stageHeight-170);
            //スペースの位置をランダムで決定
            space_pos=Math.floor(Math.random()*(solid-1));
            space.x=space_pos*interval+interval/2;
            //エンターフレーム
            addEventListener(Event.ENTER_FRAME,_enterFrame);
        }
        private function _enterFrame(event:Event):void{
            //マウスに一番近いポイントを算出しプレイヤーの現在一を決定
            for(var i:int;i<solid-1;i++){
                if(Math.abs(positions[ppos]-mouseX)>Math.abs(positions[i]-mouseX)){
                    ppos=i;
                }
            }
            //プレイヤーを移動
            player.x=positions[ppos];
            
            if(ok){
                player.x=positions[ppos];
                //一度下へ付いたかどうか
                if(hunmer.y>-(stage.stageHeight-170)){
                    //上へ行くまで引き返す。
                    hunmer.y-=speed+5;
                    space.y-=speed+5;
                }else{
                    //上についたら再び位置の決定
                    //スコアの増加
                    //スピードの増加
                    //下へ付いたかどうかをfalseに
                    ok=false;
                    hunmer.y=-(stage.stageHeight-170);
                    space.y=-(stage.stageHeight-170);
                    space_pos=Math.floor(Math.random()*(solid-1));
                    space.x=space_pos*interval+interval/2;
                    speed+=0.3;
                    score.text=String(Number(score.text)+1);
                }
            }else{
                //下へ下ろす
                hunmer.y+=speed;
                space.y+=speed;
                //一番下へ付いたときにプレーヤーはスペースにいたら場合にokをtrueへ
                if(hunmer.y>0){
                    if(ppos==space_pos){
                        ok=true;
                    }
                }else if(hunmer.y>-40){
                    //潰されているので終わり
                    if(ppos!==space_pos){
                        _end();
                    }
                }
            }
        }
        private function _end():void{
            //終わり
            removeEventListener(Event.ENTER_FRAME,_enterFrame);
            score.x=stage.stageWidth/2;
            score.y=stage.stageHeight/2;
            score.text="score:"+score.text;
        }
        private function _makePlayer():void{
            player=new Sprite();
            //頭
            player.graphics.lineStyle(3,0x333333);
            player.graphics.drawCircle(0,0,5);
            //体
            player.graphics.moveTo(0,5);
            player.graphics.lineTo(0,20);
            //腕
            player.graphics.moveTo(-10,9);
            player.graphics.lineTo(10,9);
            //足
            player.graphics.moveTo(-10,30);
            player.graphics.lineTo(0,20);
            player.graphics.lineTo(10,30);
            
            player.x=interval;
            player.y=stage.stageHeight-200;
            addChild(player);
        }
        private function _makeGround():void{
            //地面作成
            ground=new Shape();
            ground.graphics.lineStyle(1,0x999999);
            ground.graphics.beginFill(0xf4f4f4);
            ground.graphics.drawRect(0,stage.stageHeight-170,stage.stageWidth,170);
            ground.graphics.endFill();
            addChild(ground);
        }
        private function _makeHunmer():void{
            //上から落ちる物体の作成
            hunmer=new Shape();
            hunmer.graphics.lineStyle(1,0x999999);
            hunmer.graphics.beginFill(0xf4f4f4);
            hunmer.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight-170);
            hunmer.graphics.endFill();
            addChild(hunmer);
        }
        private function _makeSpace():void{
            //スペースの作成
            space=new Shape();
            space.graphics.lineStyle(1,0x999999);
            space.graphics.beginFill(0xffffff);
            space.graphics.drawRect(0,stage.stageHeight-210,interval,40);
            space.graphics.endFill();
            
            space.graphics.lineStyle(1,0xffffff);
            space.graphics.moveTo(0,stage.stageHeight-170);
            space.graphics.lineTo(interval,stage.stageHeight-170);
            space.x=0;
            space.y=0;
            addChild(space);
        }
    }
}