package 
{
	/**
	 * ...
	 * @author Kevin Schwaar
	 */
	public class Credits 
	{
		private protected var credits:int;
		private protected var bet:int;
		public function Credits() 
		{
			this.credits = 1;
			this.bet = 1;
		}
		
		public function setCredits(set_amount:int){
			this.credits = set_amount;
		}
		
		public function cashout(){
			var output:int = this.credits();
			this.credit = 0;
			return output;
		}
		
		public function incrementBet(){
			if ((this.bet == 1) && (this.credits >= 5)){
				this.bet = 5;
			}
			else if ((this.bet == 5) && (this.credits >= 10)){
				this.bet = 10;
			}
			else{
				this.bet = 10;
			}
		}
		
		public function decrementBet(){
			if ((this.bet == 5) && (this.credits >= 1)){
				this.bet = 1;
			}
			else if ((this.bet == 10) && (this.credits >= 5)){
				this.bet = 5;
			}
			else {
				this.bet = 1;
			}
		}
		
		public function requestCredits(){
			//Output some sort of "YOU LOSE" message???
		}
		
		public function setCreditBalance(input_credits:int){
			this.credits = input_credits;
		}
		
	}

}