#define __F(A,B) class A : B { scope = 1; }

class CfgVehicles {
	class House;
	__F(Land_Fire_barrel,House);
	__F(Land_Fire_barrel_burning,Land_Fire_barrel);
};
