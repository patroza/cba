#define __F(A) class A { units[]={}; requiredVersion = 1.0; requiredAddons[] = {}; }

class CfgPatches {
	class ADDON {
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"CAData"};
		version = VERSION;
		author[] = {"Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};

	// All of these actually should only be loaded when arma2 is missing...
// XEH
	__F(CA_Dubbing_Counterattack);
	__F(CAMusic);
	__F(CARocks2);
	__F(CAStructures_A_BuildingWIP);
	__F(CAStructuresLand_A_MunicipalOffice);
	__F(CAStructuresBarn_W);
	__F(CAStructures_Castle);
	__F(CAStructuresHouse);
	__F(CAStructuresHouse_A_FuelStation);
	__F(CAStructuresHouse_A_Hospital);
	__F(CAStructuresHouse_A_Office01);
	__F(CAStructuresHouse_A_Office02);
	__F(CAStructuresHouse_a_stationhouse);
	__F(CAStructuresHouse_Church_02);
	__F(CAStructuresHouse_Church_03);
	__F(CAStructuresHouse_Church_05R);
	__F(CAStructuresHouse_HouseBT);
	__F(CAStructuresHouse_HouseV2);
	__F(CAStructuresHouse_HouseV);
	__F(CAStructuresLand_Ind_Stack_Big);
	__F(CAStructures_IndPipe1);
	__F(CAStructuresInd_Quarry);
	__F(Ind_SawMill);
	__F(CAStructures_Mil);
	__F(CAStructures_Misc_Powerlines);
	__F(CAStructures_Nav);
	__F(pond_test);
	__F(CAStructures_Proxy_BuildingParts);
	__F(CAStructures_Proxy_Ruins);
	__F(CAStructures_Rail);
	__F(CAStructuresHouse_rail_station_big);
	__F(CAStructures_Ruins);
	__F(CAStructuresShed_Small);
	__F(Utes);
	__F(A_Crane_02);
	__F(A_GeneralStore_01);
	__F(CABuildings2_A_Pub);
	__F(A_statue);
	__F(Barn_Metal);
	__F(Church_01);
	__F(Farm_Cowshed);
	__F(Farm_WTower);
	__F(CAHouseBlock_A);
	__F(CAHouseBlock_B);
	__F(CAHouseBlock_C);
	__F(CAHouseBlock_D);
	__F(HouseRuins);
	__F(Ind_Dopravnik);
	__F(Ind_Expedice);
	__F(Ind_Mlyn);
	__F(Ind_Pec);
	__F(ind_silomale);
	__F(Ind_SiloVelke);
	__F(Ind_Vysypka);
	__F(Ind_Garage01);
	__F(Ind_Shed_01);
	__F(Ind_Shed_02);
	__F(Ind_Workshop01);
	__F(CABuildings2_Misc_Cargo);
	__F(Misc_PowerStation);
	__F(Misc_WaterStation);
	__F(Rail_House_01);
	__F(Shed_small);
	__F(CA_Missions);
	__F(A_TVTower);
	__F(CAStructures_Railway);
	__F(CA_Missions_Templates_SecOps);
	__F(CAWater);
	__F(CABuildingParts);
	__F(CABuildingParts_Signs);
	__F(CATEC);
	__F(Chernarus);
	__F(CAWater2_Destroyer);
	__F(CAWater2_fishing_boat);
	__F(CAWater2_Fregata);
	__F(CAWater2_LHD);
	__F(CAWater2_smallboat_1);
	__F(CATracked2_AAV);
	__F(CAWheeled2_BTR90);
	__F(CAWheeled2_GAZ39371);
	__F(CAWheeled2_Kamaz);
	__F(CAWheeled2_LAV25);
	__F(CAWheeled2_TowingTractor);
	__F(CAWheeled2_VWGolf);
	__F(CAAir2_MV22);
	__F(CAAir2_Pchela1T);
	__F(CA_CruiseMissile);
//	
// ACE
	__F(CAWeapons_bizon);
	__F(CAWeapons_VSS_vintorez);
	__F(CAWeapons2_HuntingRifle);
	__F(CAWeapons2_SMAW);
	__F(CAWeapons_M1014);
	__F(CAWeapons_Saiga12K);
	__F(CAWeapons_AmmoBoxes);
//
};


PRELOAD_ADDONS;
