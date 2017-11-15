public class DeucesWild{
	var Credit_Balance:uint;
	var Current_Bet:uint;
	var myDeck:deck = newDeck;
	var myHand:Array = new Array;
	
	
	private function incrementBet(input:uint):void{
		this.current_bet += input;
	}
	
	private function decrimentBet(input:uint):void{
		if(current_bet<=input){
			this.current_bet=1;
		}
		else{
			this.current_bet-=input;
		}
	}
	
	private function Set_Balance(input:uint):void{
		this.Credit_Balance+=input;
	}
	
	private function requestCredit():void{
		//Requests some ammount of credits from the user.
		//Calls Set_balance afterwards to set the balance.
	}
	
	private function cashout():void{
		//Create some sort of celebratory screen.
		//Output the credit balance to the user.
		this.Credit_Balance=0;
		fscommand("quit");
	}
	
	private function dealHand():void{
		this.myHand.clear();
		while(this.myHand.length()<5){
			var inx:int=(Math.random()*52);
			if(this.myHand.indexOf(this.myDeck[inx])===-1){
				this.myHand.push(this.myDeck[inx]);
				this.myDeck.removeAt(inx);
			}
		}
	}
	
	private function holdCard(incoming_card:card):card{
		if(this.incoming_card.keep_me){
			this.incoming_card.keep_me = false;
		}
		else{
			this.incoming_card.keep_me = true;
		}
		return this.incoming_card;
	}
	
	private main{
		if(this.Credit_Balance < this.Current_Bet){
			requestCredit();
		}
	
	}
	
}