//Þeyma Cengiz  1105011031
//Neslihan Hanecioglu 1105011017
//By State pattern and Singleton

//After  HasCoinState's selectCola action,this state is occurs,
//with dispenseCola action this state passes to RemainderOfCoin
//if the user inserts less than 100  or 200 cents [100 cents-> 1 liras]
//then this state passes NoCoinState.
public class ColaSoldState implements State {

	private static ColaMachine colaMachine;

	private static ColaSoldState instance;// We used singleton with state
	                                      // pattern.It is one instance of this
	                                      // class

	private ColaSoldState() {

	}

	public static ColaSoldState getInstance(ColaMachine m) {

		if (instance == null) {

			instance = new ColaSoldState();
			colaMachine = m;

		}

		return instance;

	}

	@Override
	public void insertCoin() {
		System.out.println("Please wait,we are already giving you a cola");

	}

	@Override
	public void ejectCoin() {
		System.out.println("Sorry,you do not take your coin");

	}

	@Override
	public void refillMachine() {
		System.out.println("Already the machine has cola");

	}

	@Override
	public void selectCola() {
		System.out.println("You already select a cola");

	}

	@Override
	public void dispenseCola() {

		//Enter 1, If the cans of cola is selected
		if (colaMachine.selection == 1) {
			if (colaMachine.amonutOfCoin < colaMachine.cansOfColaPrice) {
				System.out
						.println("Please take your coin and  put at least until "
								+ colaMachine.cansOfColaPrice + "!!");

				colaMachine.setState(colaMachine.getNoCoinState());
			} else {

				System.out.println("Cola is selected.Please take it..");
				colaMachine.setState(colaMachine.getRemainderOfCoin());
				colaMachine.countDecrease();

			}
		} 
		//Enter 2, If the 1 liter of cola is selected
		else if (colaMachine.selection == 2) {
			if (colaMachine.amonutOfCoin < colaMachine.oneLiterColaPrice) {
				System.out
						.println("Please take back your coin and put at least until "
								+ colaMachine.oneLiterColaPrice + "!!");
				colaMachine.setState(colaMachine.getNoCoinState());
			}

			else {
				System.out.println("Cola is selected.Please take it..");

				colaMachine.setState(colaMachine.getRemainderOfCoin());
				colaMachine.countDecrease();
			}
		}
	}

	@Override
	public void dispenseCoin() {
		System.out.println("You only take cola not coin");

	}
}
