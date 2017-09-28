//Þeyma Cengiz  1105011031
//Neslihan Hanecioglu 1105011017
//By State pattern and Singelton

//It is default state.If the machine has coin,default state is this.
import java.util.Scanner;

public class NoCoinState implements State {

	private static ColaMachine colaMachine;

	private static NoCoinState instance;// We used singleton with state
										// pattern.It is one instance of this
										// class

	private NoCoinState() {

	}

	public static NoCoinState getInstance(ColaMachine m) {

		if (instance == null) {

			instance = new NoCoinState();
			colaMachine = m;

		}

		return instance;

	}

	@Override
	public void insertCoin() {
		System.out.print("Please enter the amount of coin : ");
		Scanner sc = new Scanner(System.in);
		double n = sc.nextDouble();
		colaMachine.amonutOfCoin = n;

		System.out.println("You inserted a coin.");
		colaMachine.setState(colaMachine.getHasCoinState());

	}

	@Override
	public void ejectCoin() {
		System.out.println("You have not inserted a coin!");

	}

	@Override
	public void refillMachine() {
		System.out.println("Already the machine has cola.");

	}

	@Override
	public void selectCola() {
		System.out.println("There is no coin");

	}

	@Override
	public void dispenseCola() {
		System.out.println("You need to pay!");

	}

	@Override
	public void dispenseCoin() {
		System.out.println("You need to pay the required amount of money!");

	}

}
