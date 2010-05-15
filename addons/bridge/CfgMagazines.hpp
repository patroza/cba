#define __F(A,B) class A : B { scope = 2; }

class CfgMagazines {
	// Temporary added tree due to lacking requiredAddons
	class Default;
	class CA_Magazine: Default {};
	class CA_LauncherMagazine: CA_Magazine {};

// ACE
	__F(smaw,CA_Magazine);
	__F(M136,CA_LauncherMagazine);
	__F(RPG18,CA_LauncherMagazine);
//
};
