#define __F(A,B) class A : B { scope = 2; }

class CfgMagazines {
	class CA_Magazine;
	class CA_LauncherMagazine;

// ACE
	__F(smaw,CA_LauncherMagazine);
	__F(M136,CA_LauncherMagazine);
	__F(RPG18,CA_LauncherMagazine);
//
};
