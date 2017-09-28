//Þeyma Cengiz  1105011031
//Neslihan Hanecioðlu 1105011017
//By State pattern and Singelton

//Contex Class
public class ColaMachine {

	State colaSoldOutState;
	State noCoinState;
	State hasCoinState;
	State colaSoldState;
	State remainderOfCoinState;
	State state;
	int count = 0;
	double amonutOfCoin = 0;
	double cansOfColaPrice = 100; //100 cents ->1 liras
	double oneLiterColaPrice = 200;
	int selection;//choose cola

	public ColaMachine(int numberOfCola) {
		// ColaMachine is Context class that sends its reference to the state classes
		// Thus, state transition occurs
		colaSoldOutState = ColaSoldOutState.getInstance(this);
		noCoinState = NoCoinState.getInstance(this);
		hasCoinState = HasCoinState.getInstance(this);
		colaSoldState = ColaSoldState.getInstance(this);
		remainderOfCoinState = RemainderOfCoinState.getInstance(this);
		this.count = numberOfCola;
		if (numberOfCola > 0) {
			// Default state is noCoinState if the machine has coin
			state = noCoinState;
			// if the machine has not coin,default state is colaSoldOutState
		} else
			state = colaSoldOutState;
	}

	// The following methods calls state's method,We mean that delegate the job
	// to the state's methods.
	public void insertCoin() {
		state.insertCoin();
	}

	public void ejectCoin() {
		state.ejectCoin();
	}

	public void selectCola() {

		state.selectCola();

		state.dispenseCola();
		state.dispenseCoin();

	}

	public void refillMachine() {
		state.refillMachine();
	}

	public void countDecrease() {
		
		if (count != 0) {
			count = count - 1;
		}
	}
 
	public void setState(State state) {
		this.state = state;
	}

	public State getHasCoinState() {

		return HasCoinState.getInstance(this);

	}

	public State getNoCoinState() {

		return NoCoinState.getInstance(this);

	}

	public State getColaSoldState() {
		return ColaSoldState.getInstance(this);
	}

	public State getColaSoldOutState() {

		return ColaSoldOutState.getInstance(this);

	}

	public State getRemainderOfCoin() {

		return RemainderOfCoinState.getInstance(this);

	}

	public int getCount() {
		return count;
	}

	public String toString() {
		if (state == noCoinState)
			return "Machine is waiting for Coin!! ";
		else
			return "Machine is Empty";

	}

	
}
