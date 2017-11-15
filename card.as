public class card{
	var suit:int;
	var rank:int;
	var keep_me:Boolean;
	
	private function newCard(suit:int, rank:int, keep_me:Boolean):void{
		if(suit >=0 4 && suit < 4){
			this.suit=suit;
		}
		if(rank>=0 && rank <13){
			if(rank == 2){
				this.rank = 13
			}
			else{
				this.rank = rank;
			}
		this.keep_me=false;
		}
	}
}