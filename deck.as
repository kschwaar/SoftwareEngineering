public class deck{
	var my_Deck:Array = new Array;
	
	private function newDeck():void{
		my_Deck.clear();
		for(var suit:int=0; suit < 4; suit ++){
			for(var rank:int=0; rank < 13; rank++){
				var my_Card:card = newCard(suit, rank, false);
				my_Deck.push(my_Card);
			}
		}
	}
	
	private function shuffleDeck():void{
		for(var i:int=0; i<52; i++){
			var inx:int=(Math.random()*52);
			var tempCard = my_Deck[inx];
			my_Deck[inx] = my_Deck[i];
			my_Deck[i]=tempCard;
		}
	}	
}