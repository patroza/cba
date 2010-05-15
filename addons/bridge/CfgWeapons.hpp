#define __F(A,B) class A : B { scope = 2; }

class CfgWeapons {
	// Temporary added tree due to lacking requiredAddons
	class Default;
	class LauncherCore: Default {};
	class RifleCore: Default {};
	class Launcher: LauncherCore {};
	class Rifle: RifleCore {};

// ACE
	__F(smaw,Launcher);
	__F(M24,Rifle);
	__F(M40A3,M24);
	__F(M240,Rifle);
	__F(M249,Rifle);
	__F(Mk_48,M240);
//
};
