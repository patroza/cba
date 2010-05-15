#define __F(A,B) class A : B { scope = 2; }

class CfgWeapons {
	// Temporary added tree due to lacking requiredAddons
	class Default;
	class LauncherCore: Default {};
	class RifleCore: Default {};
	class Launcher: LauncherCore {};
	class Rifle: RifleCore {};
	class M16_Base: Rifle {};
	class M16A2: M16_Base {};
	class M16A4: M16A2 {};
	class M4A1: M16_Base {};
	class M4A1_Aim: M4A1 {};

// ACE
	__F(smaw,Launcher);
	__F(M24,Rifle);
	__F(M40A3,M24);
	__F(M240,Rifle);
	__F(M249,Rifle);
	__F(Mk_48,M240);
//
};
