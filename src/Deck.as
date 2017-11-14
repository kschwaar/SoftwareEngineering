//this is going to be the deck class

package{
	public class Deck{
		
		
		private var pile:Vector.<Card>;
		//constuctor
		public function Deck(){
			pile = new Vector.<Card>();
			
			var s:int;
			var n:int;
			for (s = 0 ; s < Card.SUITS.length ; s++){
				for (n = 0; n < Card.NUMBERS.length; n++){
					pile.push(new Card(Card.SUITS[s], Card.NUMBERS[n]));
				}
			}
			shuffle();
		}
		
		//this should only really be used in the constructor, anywhere else is just redundant
		private function shuffle():void{
			//TODO
			//get really random cards. this isn't working for some reason
			//each deck, after getting shuffled just gives the same deck
			pile.sort(Card.randomOrder);
			pile.sort(Card.randomOrder);
			return;
		}
		
		public function popCard():Card{
			if(pile.length > 0){
				return pile.pop();
			}
			else{
				return new Card(Card.SPADE, Card.ACE);
			}
		}
		
		public static function winType(handOrg:Vector.<Card>):String{
			var handCopy:Vector.<Card> = handOrg.concat();
			
			//TODO
			//test all the win check funcitons
			if (isRoyalFlush(handCopy)){
				return "royal_flush";
			}
			else if (isStraightFlush(handCopy)){
				return "straight_flush";
			}
			else if (isFourOfAKind(handCopy)){
				return "four_of_a_kind";
			}
			else if (isFullHouse(handCopy)){
				return "full_house";
			}
			else if (isFlush(handCopy)){
				return "flush";
			}
			else if (isStraight(handCopy)){
				return "straight";
			}
			else if (isThreeOfAKind(handCopy)){
				return "three_of_a_kind";
			}
			else if(isTwoPair(handCopy)){
				return "two_pair";
			}
			else if (isPair(handCopy)){
				return "pair";
			}
			else{
				return "lose";
			}
		}
		
		private static function isRoyalFlush(hand:Vector.<Card>):Boolean{			
			var errors:int = 0;
			var twos:int = countTwos(hand);
			hand.sort(Card.numberOrder);
			
			if ((hand[twos].getNumber() < 10) && isStraightFlush(hand)){
				return true;
			}
			else{
				return false;
			}
		}
		
		
		private static function isStraightFlush(hand:Vector.<Card>):Boolean{
			if (isStraight(hand) && isFlush(hand)){
				return true;
			}
			else{
				return false;
			}
		}
		
		private static function isFourOfAKind(hand:Vector.<Card>):Boolean{
			var twos:int = countTwos(hand);
			hand.sort(Card.numberOrder);
			
			var highestMatches = 1;
			var curMatches = 1;
			var i:int;
			for (i = twos; i < hand.length-1; i++){
				if (hand[i].getNumber() == hand[i + 1].getNumber() ){
					curMatches++;
					if (curMatches > highestMatches){
						highestMatches = curMatches;
					}
				}
				else{
					curMatches = 1;
				}
			}
			var ref:int = twos + highestMatches;
			if (ref >= 4){
				return true;
			}
			else{
				return false;
			}
		}
		
		
		private static function isFullHouse(hand:Vector.<Card>):Boolean{
			var twos:int = countTwos(hand);
			hand.sort(Card.numberOrder);
			
			var i:int;
			var type1:int = hand[twos].getNumber();
			var type2:int = hand[hand.length-1].getNumber();
			
			for (i = twos; i < hand.length; i++){
				if ((hand[i].getNumber() != type1) && (hand[i].getNumber() != type2)){
					return false;
				}
			}
			return true;
		}

		
		
		
		private static function isFlush(hand:Vector.<Card>):Boolean{
			var twos:int = countTwos(hand);
			hand.sort(Card.numberOrder);
			
			var i:int;
			for (i = twos; i < hand.length-1; i++){
				if (!(hand[i].getSuit() == hand[i + 1].getSuit())){
					return false;
				}
			}
			return true;
		}
		
		
		
		private static function isStraight(hand:Vector.<Card>):Boolean{
			var twos:int = countTwos(hand);
			hand.sort(Card.numberOrder);
			
			var min:int = hand[twos].getNumber();
			var max:int = hand[hand.length - 1].getNumber();
			if ((max - min) > 4){
				return false;
			}
			for (var i:int = twos; i < hand.length-1; i++){
				if (hand[i].getNumber == hand[i + 1].getNumber){
					return false;
				}
			}
			return true;
		}
		
		
		private static function isThreeOfAKind(hand:Vector.<Card>):Boolean{
			var twos:int = countTwos(hand);
			hand.sort(Card.numberOrder)
			
			var highestMatches = 1;
			var curMatches = 1;
			
			var i:int;
			for (i = twos; i < hand.length-1; i++){
				if (hand[i].getNumber() == hand[i + 1].getNumber() ){
					curMatches++;
					if (curMatches > highestMatches){
						highestMatches = curMatches;
					}
				}
				else{
					curMatches = 1;
				}
			}
			var ref:int = twos + highestMatches;
			if (ref >= 3){
				return true;
			}
			else{
				return false;
			}
		}
		
		
		
		
		
		private static function isTwoPair(hand:Vector.<Card>):Boolean{
			var twos:int = countTwos(hand);
			hand.sort(Card.numberOrder)
			var pairs:int = 0;
			
			var i:int;
			for (i = twos; i < hand.length-1; i++){
				if (hand[i].getNumber() == hand[i + 1].getNumber()){
					pairs++;
					//this is to skip the card that we just matched with a card for a pair.
					//that way a 3 of a kind doesn't look like a 2 pair.
					i++;
				}
			}
			var ref:int = pairs + twos;
			if (ref>=2){
				return true;
			}
			else{
				return false;
			}
		}
		
		
		
		
		
		
		public static function isPair(hand:Vector.<Card>):Boolean{
			//get wilds out of the way
			if (countTwos(hand) > 0){
				return true;
			}
			hand.sort(Card.numberOrder);
			
			var i:int;
			for (i = 0; i < hand.length-1; i++){
				if (hand[i].getNumber() == hand[i + 1].getNumber() ){
					return true;
				}
			}
			return false;
		}
		
		
		
		
		
		
		
		// this is a utill method for finding wins
		private static function countTwos(hand:Vector.<Card>):int{
			var count:int = 0;
			
			var i:int;
			for (i = 0; i < hand.length; i++){
				if (hand[i].getNumber() == Card.TWO){
					count++;
				}
			}
			return count;
		}
	
		
	}
	
}