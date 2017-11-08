// ---------------------------------------
//	Casino Game Maker, Inc.
// ---------------------------------------

package
{
	import Encoders.IMAGE_ENCODER;
	import Events.LOADING_EVENT;
	import Extended.*;
	import starling.events.*;
	import starling.utils.AssetManager;
	import starling.core.Starling;
	import Roulette.ROULETTE_BETS;
	import treefortress.textureutils.TextureLoader;

	public class GAME extends DISPLAY
	{
		private var background_Image:E_IMAGE;
		private var cardImages:Vector.<E_IMAGE>;
		private var holdButtons:Vector.<E_BUTTON>;
		private var debug_area:E_TEXT;
		
		private var creditMeter:E_METER;
		private var creditMeterBack:E_IMAGE;
		private var credits:Number;
		private var win_image:E_IMAGE;
		
		private var deal_button:E_BUTTON;
		private var betButtons:Vector.<E_BUTTON>;
		private var bet:int;
		
		
		private var dealt:Boolean;
		private  static var moveTime:int = 300;
		
		
		private var deck:Deck;
		private var hand:Vector.<Card>;
		
		private var _Asset_Loader:ASSET_LOADER;
		private var _Assets:AssetManager;
		private var _Config:XML;
		
		private var _Payout:XML;
		
		private var _Math_Config:XML;
		private var _Directory:String;
		private var _Locality:LOCALITY;

		public function GAME(directory:String)
		{
			_Directory = directory + "/";

			_Asset_Loader = new ASSET_LOADER(Directory, Asset_Loader_Handler);
			Asset_Loader.Add_Directory(Directory);
			Asset_Loader.Start();
		}

		private function Asset_Loader_Handler(ratio:Number):void
		{
			var Loading_Event:LOADING_EVENT = new LOADING_EVENT(LOADING_EVENT.EVENT_LOADING_STATUS);
			Loading_Event.Percentage = ratio;
			dispatchEvent(Loading_Event);

			if(ratio < 1) return;

			//Assets are what we use to get sounds, images, animations...
			_Assets			= Asset_Loader.Get_Assets();
			
			//The config file is where all the information for our text areas, image, and other variables are stored.
			_Config			= Assets.getXml("Game");
			
			_Payout			= Assets.getXml("Payout");
			
			
			
			//The math config is where the information about win check will be stored. 
			_Math_Config 	= Assets.getXml("Math");
			
			//Locality stores information about strings and different languages. 
			_Locality 		= new LOCALITY(Assets.getXml("Locality"));
			Locality.addEventListener(LOCALITY.EVENT_LANGUAGE_CHANGED, Locality_Handler);
			
			//init backend
			deck = new Deck();
			hand = new Vector.<Card>;
			hand.length = 5;
			dealt = false;
			
			
			
			//init UI elements
			background_Image = new E_IMAGE(Assets, Config.Game.Background);
			debug_area = new E_TEXT(Config.Game.Debug_Area);
			
			cardImages = new Vector.<E_IMAGE>();
			cardImages.push(new E_IMAGE(Assets, Config.Game.Card1));
			cardImages.push(new E_IMAGE(Assets, Config.Game.Card2));
			cardImages.push(new E_IMAGE(Assets, Config.Game.Card3));
			cardImages.push(new E_IMAGE(Assets, Config.Game.Card4));
			cardImages.push(new E_IMAGE(Assets, Config.Game.Card5));
			
			holdButtons = new Vector.<E_BUTTON>();
			holdButtons.push(new E_BUTTON(Assets, Config.Game.Hold1));
			holdButtons.push(new E_BUTTON(Assets, Config.Game.Hold2));
			holdButtons.push(new E_BUTTON(Assets, Config.Game.Hold3));
			holdButtons.push(new E_BUTTON(Assets, Config.Game.Hold4));
			holdButtons.push(new E_BUTTON(Assets, Config.Game.Hold5));
			
			betButtons = new Vector.<E_BUTTON>();
			betButtons.push(new E_BUTTON(Assets, Config.Game.Bet_one));
			betButtons.push(new E_BUTTON(Assets, Config.Game.Bet_five));
			betButtons.push(new E_BUTTON(Assets, Config.Game.Bet_ten));
			
			bet = 1;
			
			creditMeter = new E_METER(Config.Game.Credits);
			creditMeterBack = new E_IMAGE(Assets, Config.Game.CreditsBack);
			credits = 50;
			creditMeter.Set(credits);
			
			win_image = new E_IMAGE(Assets, Config.Game.Win_Image);
			
			var i:int;
			for (i = 0; i < holdButtons.length; i++){
				holdButtons[i].addEventListener(BUTTON.EVENT_TOUCHED, hold(holdButtons[i]));
				holdButtons[i].Text = "Hold";
			}
		
			
			deal_button = new E_BUTTON(Assets, Config.Game.Deal_Button);
			deal_button.addEventListener(BUTTON.EVENT_TOUCHED, deal);
			deal_button.Text = "Deal";

			
			
			//When you have an image, animation, text field, etc. you need to make sure that you add the child to the stage or else it won't show up. 
			Add_Children([
				background_Image,
				debug_area,
				
				cardImages[0],
				cardImages[1],
				cardImages[2],
				cardImages[3],
				cardImages[4],
				
				holdButtons[0],
				holdButtons[1],
				holdButtons[2],
				holdButtons[3],
				holdButtons[4],
				
				deal_button,
				creditMeterBack,
				creditMeter,
				win_image,
				
				betButtons[0],
				betButtons[1],
				betButtons[2]
			]);
			
			
			//Listeners
			this.addEventListener(Event.ENTER_FRAME, Enter_Frame_Handler);
			
			Locality_Handler();
		}
		
		public function Locality_Handler():void
		{
			//Update text when language changes.
		}

		
		//this is the main loop!!!!!! -------------------------------------------------------------------------------------------
		private function Enter_Frame_Handler():void
		{
			//Constantly update the instruction area with the random number.
		}
		
		//These are methods that are meant to be attached to event listeneres
		private function deal():void{
				//re deal
			if(dealt){
				var i:int;
				for (i = 0; i < hand.length; i++){
					if(!hand[i].isHeld()){
						hand[i] = deck.popCard();
						cardImages[i].Flip(
							Assets.getTexture(hand[i].getTextureName()),
							200, 
							cardImages[i].x, cardImages[i].y, 
							cardImages[i].scale);
					}
				}
				for (i = 0; i < holdButtons.length; i++){
					holdButtons[i].Enabled = false;
				}
				
				//Post game responsibilities -----------------------------------------------------------------------LOOK HERE NIMROD
				var win:String = Deck.winType(hand);
				var mult:Number;
				var text:String;
				
				
				if (win == Payout.NoHand.@Hand){
					mult = Payout.NoHand.@Multiplier;
					text = Payout.NoHand.@Texture;
				}
				else if (win == Payout.Pair.@Hand){
					mult = Payout.Pair.@Multiplier;
					text = Payout.Pair.@Texture;
				}
				else if (win == Payout.Two_Pair.@Hand){
					mult = Payout.Two_Pair.@Multiplier;
					text = Payout.Two_Pair.@Texture;
				}
				else if (win == Payout.Three_Of_A_Kind.@Hand){
					mult = Payout.Three_Of_A_Kind.@Multiplier;
					text = Payout.Three_Of_A_Kind.@Texture;
				}
				else if (win == Payout.Straight.@Hand){
					mult = Payout.Straight.@Multiplier;
					text = Payout.Straight.@Texture;
				}
				else if (win == Payout.Flush.@Hand){
					mult = Payout.Flush.@Multiplier;
					text = Payout.Flush.@Texture;
				}
				else if (win == Payout.Full_House.@Hand){
					mult = Payout.Full_House.@Multiplier;
					text = Payout.Full_House.@Texture;
				}
				else if (win == Payout.Four_Of_A_Kind.@Hand){
					mult = Payout.Four_Of_A_Kind.@Multiplier;
					text = Payout.Four_Of_A_Kind.@Texture;
				}
				else if (win == Payout.Straight_Flush.@Hand){
					mult = Payout.Straight_Flush.@Multiplier;
					text = Payout.Straight_Flush.@Texture;
				}
				else if (win == Payout.Royal_Flush.@Hand){
					mult = Payout.Royal_Flush.@Multiplier;
					text = Payout.Royal_Flush.@Texture;
				}
				else{
					text = Payout.NoHand.@Texture;
					mult = -3;
				}
				
				credits += mult;
				creditMeter.Set(credits);
				
				//change to new texture 
				win_image.Flip(Assets.getTexture(text), 200, win_image.x, win_image.y);
				
				debug_area.Text = win;
				dealt = false;
				
				
				
				
				
				
			}
			//first hand
			else{
				deck = new Deck();
				var i:int;
				for (i = 0; i < hand.length; i++){
					hand[i] = deck.popCard();
					cardImages[i].Flip(
						Assets.getTexture(hand[i].getTextureName()),
						200,
						cardImages[i].x, cardImages[i].y,
						cardImages[i].scale);
				}
				for (i = 0; i < holdButtons.length; i++){
					holdButtons[i].Enabled = true;
				}
				dealt = true;
			}
			var i:int;
			for (i = 0; i < hand.length; i++){
				if (hand[i].isHeld()){
					hand[i].setHeld(false);
					cardImages[i].Move_To(cardImages[i].x, Config.Game.Card1.@Y, moveTime);
				}
			}
		}
		
		
		private function hold(button:E_BUTTON):Function{
			var index:int;
			index = holdButtons.indexOf(button);
			function out():void{
				if(dealt){
					if (hand[index].isHeld()){
						hand[index].setHeld(false);
						cardImages[index].Move_To(cardImages[index].x, Config.Game.Card1.@Y, moveTime);
					}
					else{
						hand[index].setHeld(true);
						cardImages[index].Move_To(cardImages[index].x, Config.Game.Card1.@Y - 50, moveTime);
					}
				}
			}
			return out;
		}
		
	
		//Getters 
		public function get Asset_Loader():ASSET_LOADER
		{
			return _Asset_Loader;
		}
		
		public function get Assets():AssetManager
		{
			return _Assets;
		}
		
		public function get Config():XML		
		{
			return _Config;
		}
		
		public function get Math_Config():XML
		{
			return _Math_Config;
		}
		
		public function get Directory():String
		{
			return _Directory;
		}
		
		public function get Locality():LOCALITY
		{
			return _Locality;
		}
		
		public function get Payout():XML{
			return _Payout;
		}
	}
}