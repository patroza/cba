#define __F(A,B) class A : B { scope = 2; }

class CfgWeapons {
	class Launcher;
	class Rifle;

// ACE
	__F(smaw,Launcher);
	__F(M24,Rifle);
	__F(M40A3,M24);
	__F(M240,Rifle);
	__F(M249,M240);
	__F(Mk_48,M240);
//
};
