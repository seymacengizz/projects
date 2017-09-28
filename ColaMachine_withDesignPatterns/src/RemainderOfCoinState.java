//Þeyma Cengiz  1105011031
//Neslihan Hanecioglu 1105011017
//By State pattern and Singelton

//If the user inserts more than 100 or 200 coin,this state gives the remainder of the user coin.
//If the count of cola is more than 0 after the one cola is sold,then this machine goes NoCoinState
//Otherwise,this machine goes to ColaSoldOutState.
public class RemainderOfCoinState implements State {

	private static ColaMachine colaMachine;
	double remainderOfCoin;

	private static RemainderOfCoinState instance;// We used singelton with state

	// pattern.It is one instance of this
	// class

	private RemainderOfCoinState() {

	}

	public static RemainderOfCoinState getInstance(ColaMachine m) {

		if (instance == null) {

			instance = new RemainderOfCoinState();
			colaMachine = m;

		}

		return instance;

	}

	@Override
	public void insertCoin() {
		System.out.println("You already insert coin");

	}

	@Override
	public void ejectCoin() {
		System.out.println("You can not eject the coin");

	}

	@Override
	public void selectCola() {
		System.out.println("You already select cola");

	}

	@Override
	public void dispenseCola() {
		System.out.println("Your cola already is dispensed ");

	}

	@Override
	public void dispenseCoin() {
		if (colaMachine.getCount() > 0) {
			colaMachine.setState(colaMachine.getNoCoinState());
		} else {
			colaMachine.setState(colaMachine.getColaSoldOutState());
		}
		
		//Enter 1, If the cans of cola is selected
		if (colaMachine.selection == 1) {
			if (colaMachine.amonutOfCoin > colaMachine.cansOfColaPrice) {
				remainderOfCoin = (colaMachine.amonutOfCoin - colaMachine.cansOfColaPrice);
				System.out.println("Please take your  remaining coin "
						+ (remainderOfCoin));
			}
		}
		//Enter 2, If the 1 liter of cola is selected
		else {
			if (colaMachine.amonutOfCoin > colaMachine.oneLiterColaPrice) {
				remainderOfCoin = (colaMachine.amonutOfCoin - colaMachine.cansOfColaPrice);
				System.out.println("Please take your remaining coin "
						+ (remainderOfCoin));
			}

		}

	}

	@Override
	public void refillMachine() {
		System.out.println("Already the machine has cola");

	}

}
