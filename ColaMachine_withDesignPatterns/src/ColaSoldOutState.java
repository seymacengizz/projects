//Þeyma Cengiz  1105011031
//Neslihan Hanecioglu 1105011017
//By State pattern and Singelton

//This state is used when the machine has not coin.
//If the machine is refilled,then this state goes to NoCoinState
import java.util.Scanner;

public class ColaSoldOutState implements State {
	private static ColaMachine colaMachine;

	private static ColaSoldOutState instance;// We used singelton with state

	// pattern.It is one instance of this
	// class

	private ColaSoldOutState() {

	}

	public static ColaSoldOutState getInstance(ColaMachine m) {

		if (instance == null) {

			instance = new ColaSoldOutState();
			colaMachine = m;

		}

		return instance;

	}

	@Override
	public void insertCoin() {
		System.out
				.println("Sorry,you cannot insert a coin! The machine is empty");

	}

	@Override
	public void ejectCoin() {
		System.out
				.println("Sorry,you cannot eject, you have not inserted a coin yet");

	}

	@Override
	public void selectCola() {
		System.out.println("Sorry,there are no cola");

	}

	@Override
	public void dispenseCola() {
		System.out.println("Sorry,no cola dispensed");
	}

	@Override
	public void refillMachine() {
		System.out.println("Please enter the number of cola to add : ");
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		colaMachine.count = n;
		System.out.println(n+ " cola is added");
		colaMachine.setState(colaMachine.getNoCoinState());
	}

	@Override
	public void dispenseCoin() {
		
	}
}