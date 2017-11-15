//this should be the card class

package{
	public class Card{
	
		//the suits are off numbered so that they don't accidently match with card values
		public static const DIAMOND:String = "diamond";
		public static const CLUB:String  = "club";
		public static const HEART:String = "heart";
		public static const SPADE:String = "spade";
		
		// card values
		public static const ACE:int = 14;
		public static const TWO:int = 2;
		public static const THREE:int = 3;
		public static const FOUR:int = 4;
		public static const FIVE:int = 5;
		public static const SIX:int = 6;
		public static const SEVEN:int = 7;
		public static const EIGHT:int = 8;
		public static const NINE:int = 9;
		public static const TEN:int = 10;
		public static const JACK:int = 11;
		public static const QUEEN:int = 12;
		public static const KING:int = 13;
		
		//arrays filled with the constants
		public static const SUITS:Array = [DIAMOND,CLUB,HEART,SPADE];
		public static const NUMBERS:Array = [TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING, ACE];
		
		//these are the private values
		private var suit:String;
		private var number:int;
		private var held:Boolean;
		
		
		//constructors
		public function Card(valSuit:String,valNumber:int){
			this.setSuit(valSuit);
			this.setNumber(valNumber);
			this.held = false;
		}
		//util
		public function iterate():void{
			if (number < ACE){
				number++;
			}
			else{
				number = TWO;
				var suitIndex:int = SUITS.indexOf(suit);
				if (suitIndex < SUITS.length){
					suit = SUITS[++suitIndex];
				}
				else{
					suit = SUITS[0];
				}
			}
		}
		
		//sorts
		public static function randomOrder(a:Card, b:Card):int{
			//TODO, get really random numbers. here, we get the same numbers in the same order every time for some reason
			if (Math.random() < 0.5) return -1;
			else return 1;
		}
		
		public static function numberOrder(a:Card, b:Card):int{
			if (a.number < b.number){
				return -1;
			}
			else if (a.number > b.number){
				return 1;
			}
			else{//if number is same, sort on suit
				var indexA:int = -1;
				var indexB:int = -1;
				
				var i:int;
				for (i = 0 ; i < SUITS.length ; i++){
					if (a.suit == SUITS[i]){ indexA = i; }
					if (b.suit == SUITS[i]){ indexB = i; }
					if (!(indexA == -1 || indexB == -1)){ break; }
				}
				if (indexA < indexB){
					return -1;
				}
				else if (indexA > indexB){
					return 1;
				}
				else{ //suit and number are the same
					return 0;
				}
			}
		}
		
		public static function suitOrder(a:Card, b:Card):int{
			var indexA:int = -1;
			var indexB:int = -1;
			
			var i:int;
			for (i = 0 ; i < SUITS.length ; i++){
				if (a.suit == SUITS[i]){ indexA = i; }
				if (b.suit == SUITS[i]){ indexB = i; }
				if (!(indexA == -1 || indexB == -1)){ break; }
			}
			if (indexA < indexB){
				return -1;
			}
			else if (indexA > indexB){
				return 1;
			}
			else{//suit is the same, sort on number
				return numberOrder(a, b);
			}
			
		}
		
		//filters
		public static function isNotWild(c:Card):Boolean{
			if (!(c.number == TWO)){
				return true;
			}
			else{
				return false;
			}
		}
		
		//UI based
		public function getTextureName():String{
			if(this.number < JACK){
				return this.number + "_of_" + this.suit + "s";
			}
			else if ( this.number == JACK){
				return "jack_of_" + this.suit + "s";
			}
			else if ( this.number == QUEEN){
				return "queen_of_" + this.suit + "s";
			}
			else if ( this.number == KING){
				return "king_of_" + this.suit + "s";
			}
			else if ( this.number == ACE){
				return "ace_of_" + this.suit + "s";
			}
			else{
				return "black_joker";
			}
		
		
		
		}
		
		
		//getters
		public function getSuit():String{
			return this.suit;
		}
		public function getNumber():int{
			return this.number;
		}
		public function isHeld():Boolean{
			return this.held;
		}
		
		//setters
		public function setSuit(valSuit:String):void{
			var good:Boolean = false;
			
			var i:int;
			for (i = 0; i < SUITS.length ; i++){
				if (SUITS[i] == valSuit){
					good = true;
				}
			}
			if(good){
				this.suit = valSuit;
			}
			else{
				this.suit = SPADE;
			}
		}
		
		
		public function setNumber(valNumber:int):void{
			var good:Boolean = false;
			
			var i:int;
			for (i = 0; i < NUMBERS.length ; i++){
				if (NUMBERS[i] == valNumber){
					good = true;
				}
			}
			if(good){
				this.number = valNumber;
			}
			else{
				this.number = ACE
			}
		}
		
		public function setHeld(hold:Boolean):void{
			this.held = hold;
		}
	}
}