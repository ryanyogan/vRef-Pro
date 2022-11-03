import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'model/other_details.dart';
import 'model/plane_categories.dart';
import 'model/question_details.dart';
import 'model/system_list.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  readFromLocalAssets() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "VrefProDatabase.db");
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data =
          await rootBundle.load(join('assets/db', 'VrefProDatabase.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "QuestionDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Questions (id INTEGER PRIMARY KEY,system_id INTEGER,question TEXT,answer TEXT,description TEXT)');
      await db.execute(
          'CREATE TABLE PlaneCategories (id INTEGER PRIMARY KEY,name TEXT)');
      await db.execute(
          'CREATE TABLE SystemList (id INTEGER PRIMARY KEY,plane_id INTEGER,name TEXT,status BOOLEAN)');
      await db.execute(
          'CREATE TABLE OtherDetails (id INTEGER PRIMARY KEY,help TEXT,disclaimer TEXT,about TEXT)');

      await db.execute(
          'CREATE TABLE Image (id INTEGER PRIMARY KEY,question_id INTEGER,image TEXT)');

      // Your insert scripts here...
      // PlaneCategories Insert Scripts...
      await db.execute('INSERT INTO PlaneCategories VALUES(1,"")');

      // SystemList Insert Scripts
      await db.execute('INSERT INTO SystemList VALUES(1, 1, "GENERAL", 0)');
      await db.execute('INSERT INTO SystemList VALUES(2, 1, "LIMITATIONS", 0)');
      await db.execute('INSERT INTO SystemList VALUES(3, 1, "ELECTRCAL", 0)');
      await db.execute('INSERT INTO SystemList VALUES(4, 1, "HYDRAULICS", 0)');
      await db.execute(
          'INSERT INTO SystemList VALUES(5, 1, "AIR CONDITIONING", 0)');
      await db.execute('INSERT INTO SystemList VALUES(6, 1, "FUEL", 0)');
      await db
          .execute('INSERT INTO SystemList VALUES(7, 1, "PRESSURIZATION", 0)');
      await db
          .execute('INSERT INTO SystemList VALUES(8, 1, "FLIGHT CONTROLS", 0)');
      await db.execute(
          'INSERT INTO SystemList VALUES(9, 1, "LANDING GEAR / BRAKES", 0)');
      await db
          .execute('INSERT INTO SystemList VALUES(10, 1, "APU / ENGINES", 0)');
      await db
          .execute('INSERT INTO SystemList VALUES(11, 1, "RED BOX ITEMS", 0)');

      // Questions Insert Scripts
      await db.execute(
          'INSERT INTO Questions VALUES (  1  ,  1  ,  "WHAT IS THE LENGTH, WING SPAN AND HEIGHT OF THE FALCON 900EX ?", "LENGTH = 66 FT 4 IN" || char(10) || "WING SPAN = 63 FT 5 IN "|| char(10) ||"HEIGHT = 25 FT 2 IN (WITH ANTENNAE)", 0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 2  ,  1  ,  "THE MINIMUM TURNING RADIUS WITH NOSEWHEEL STEERING IS ?", "47 FEET  7 INCHES" ,0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 3  ,  1  ,  "WHEN THE CABIN DOOR IS NOT FULLY CLOSED WHAT IS INDICATED ?", "THE RED ""CABIN"" LIGHT ILLUMINATED IN THE COCKPIT.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 4  ,  1  ,  "WILL THE EMERGENCY EXIT IN THE CABIN ILLUMINATE THE ""DOOR OPEN"" WARNING SYSTEM ?", "NO",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 5  ,  1  ,  "IS THE BAGGAGE COMPARTMENT PRESSURIZED ?  HEATED ?", "YES,  PRESSURIZED - BUT NOT HEATED.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 6  ,  1  ,  "WHAT ITEMS ARE POWERED FROM THE BATTERY BUS ON THE GROUND ?", "THE FUELING PANEL, VENT VALVES,  FIRE PROTECTION,  BAGGAGE DOOR,  MAIN CABIN DOORWAY LIGHT,  BAGGAGE LIGHT",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 7  ,  1  ,  "WHAT POWERPLANTS ARE USED ON THE F900 EX AIRCRAFT ?", "GARRETT TFE731-60",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 8  ,  1  ,  "WHAT ARE THESE ENGINES RATED AT ?", "5000 LBS OF THRUST",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 9  ,  2  ,  "WHAT IS THE MAX RAMP WEIGHT OF THE FALCON 900 EX ?", "49,200 LBS OR WITH SB 1B",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 10 ,  2  ,  "WHAT IS THE MAX TAKEOFF WEIGHT ?", "49,000 LBS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 11 ,  2  ,  "WHAT IS THE MAX ZERO FUEL WEIGHT ?", "30,864 LBS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 12 ,  2  ,  "WHAT IS THE MAX LANDING WEIGHT ?", "44,500 LBS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 13 ,  2  ,  "WHAT IS THE MAX OPERATING ALTITUDE ?", "51, 000 FT",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 14 ,  2  ,  "WHAT IS THE MIN AND MAX ALTITUDE FOR T/O AND LANDING ?", "-1000 FT TO 14, 000 FT",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 15 ,  2  ,  "WHAT IS THE MIN / MAX TEMP FOR TAKEOFF AND LANDING", "-54C  to  +50C",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 16 ,  2  ,  "WHAT IS THE MAX ALTITUDE FOR OPERATING FLAPS OR SLATS ?", "20, 000 FT",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 17 ,  2  ,  "WHAT IS THE SLATS & FLAPS 7 MAX SPEED ?", "200",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 18 ,  2  ,  "WHAT IS THE SLATS & FLAPS 20 MAX SPEED ?", "190",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 19 ,  2  ,  "WHAT IS THE SLATS & FLAPS 48 MAX SPEED ?", "180",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 20 ,  2  ,  "WHAT IS THE MAX Va MANUEVERING SPEED ?", "228",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 21 ,  2  ,  "WHAT IS THE TURBULENT AIR PENETRATION SPEED ?", "280 / .76M",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 22 ,  3  ,  "HOW MANY GENERATORS ARE ON THE FALCON 900 ?", "4 (FOUR)",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 23 ,  3  ,  "HOW MANY BATTERIES ARE ON THE FALCON 900 EX ?", "2 (TWO)",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 24 ,  3  ,  "WHAT ARE THE GENERATORS RATED AT ?", "300 AMPS UP TO FL390"|| char(10) ||"260 AMPS ABOVE FL390"|| char(10) ||"350 AMPS TRANSIENT",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 25 ,  3  ,  "WHAT IS THE SYSTEM MAX VOLTAGE ?", "32 VOLTS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 26 ,  3  ,  "WHAT GENERATORS POWER THE LEFT MAIN BUS ?", "ENGINE 1 AND ENGINE 3 GENERATORS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 27 ,  3  ,  "WHAT IS THE PRIMARY POWER FOR ENGINE START ?", "BATTERIES ,  THE APU GENERATOR ONLY ASSISTS.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 28 ,  3  ,  "WHAT IS THE MINIMUM BATTERY VOLTAGE FOR ENGINE START ?", "22 VOLTS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 29 ,  3  ,  "WHAT IS THE MINIMUM BATTERY VOLTAGE FOR APU START ?", "23 VOLTS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 30 ,  3  ,  "WHAT IS THE AVERAGE TOTAL ELECTRICAL LOAD IN CRUISE ?", "320 TO 360 AMPS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 31 ,  3  ,  "CAN A GPU BE USED TO CHARGE BATTERIES ?", "NO,  UNABLE",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 32 ,  3  ,  "WHAT MUST BE SELECTED ON THE ELECTRICAL PANEL TO START ENGINES AND APU ?", "THE BUS-TIE ROTERY SW MUST BE SELECTED TO THE  TIED  POSITION IN-LINE" || char(10) ||"ALL GEN SW ON",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 33 ,  4  ,  "WHAT SUPPLIES THE MAIN HYDRAULIC POWER ?", "3 - SELF REGULATING PUMPS BY EACH ENGINE.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 34 ,  4  ,  "WHAT IS THE REGULATED OUTPUT PRESSURE OF THESE PUMPS ?", "2, 957 PSI + OR - 200 PSI",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 35 ,  4  ,  "WHAT SYSTEM DOES THE STANDBY HYDRAULIC PUMP SUPPLY PRESSURE TO IN THE EVENT OF PUMP FAILURE ?", "THE NUMBER 2 SYSTEM",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 36 ,  4  ,  "WHAT CONDITION IS NECESSARY FOR THE ST-BY PUMP TO OPERATE WITH THE SWITCH IN THE ON POSITION ?", "THE NUMBER 2 SYSTEM DROPS BELOW 1400 psi",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 37 ,  4  ,  "WHAT TYPE OF HYDRAULIC FLUID IS PERMITTED ?", "MIL-H-5606",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 38 ,  4  ,  "WHAT CAN CAUSE A  ST-BY PUMPS LIGHT ON STEADY ?", "THE ST-BY PUMP ON FOR 60 SECONDS OR MORE, OR THE MAINTENANCE GROUND USE HANDLE IN E & E BAY IN GROUND.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 39 ,  4  ,  "WHAT IS THE MAXIMUM SPEED WITH ONE OR BOTH HYDRAULIC SYSTEMS FAILED ?", ".76 M   /   260 KTS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 40 ,  4  ,  "WHAT ARE THE PRE-CHARGE PRESSURES FOR THE SYSTEM,  T/R AND PARKING BRAKE ACCUMULATORS.", "SYSTEM AND T/R   1500 psi",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 41 ,  4  ,  "WHAT SYSTEMS ARE SUPPLIED BY THE #1 HYDRAULIC SYSTEM ?", "NORMAL BRAKES, SLATS"|| char(10) ||"GEAR, FLIGHT CONTROLS (1-BARRELL)"|| char(10) ||"ARTHUR Q",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 42 ,  4  ,  "WHAT PUMPS PROVIDE PRESSURE TO #2 SYSTEM ?", "ENGINE 2 HYD PUMP AND ST-BY HYD PUMP",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 43 ,  5  ,  "WHAT ARE THE SOURCES OF AIR FOR THE AIR CONDITIONING SYSTEM ?", "THE SOURCES OF AIR CONSIST OF LP COMPRESSOR,  HP COMPRESSOR AND APU AIR.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 44 ,  5  ,  "WHAT SEQUENCE OCCURS AT TAKE OFF POWER TO THE BLEED SYSTEM ?", "THE BLEEDS CLOSE,  NO AIR SUPPLY TO CREW AND PAX.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 45 ,  5  ,  "WHEN DOES THE SYSTEM RESTORE AIR SUPPLY TO THE ECU ?", "IT STARTS AFTER LIFT OFF AND SEQUENCES TO FULL NORMAL AFTER 2 MINUTES.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 46 ,  5  ,  "WHAT HAPPENS TO THE WATER EXTRACTED FROM THE WATER SEPERATORS ?", "IT IS SPRAYED OVER THE HEAT EXCHANGERS TO INCREASE EFFICIENCY.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 47 ,  5  ,  "WHEN DO THE BLLEED VALVES START TO CLOSE ON THE GROUND ?", "WHEN ANY PLA EXCEEDS 54 DEGREES.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 48 ,  5  ,  "WHEN DOES THE ECU TURBOFAN AUTOBRAKE ITS ROTATION ?", "AT 300 TAS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 49 ,  5  ,  "WHAT IS THE PRIMARY FUNCTION OF THE TURBOFAN ?", "TO ASSIST IN COOLING ON THE GROUND,  OR IN-FLIGHT WITH THE GEAR DOWN,  SLATS EXTENDED,  OR BELOW 300 TAS.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 50 ,  5  ,  "WHAT WILL CAUSE THE CONDG OVHT LIGHT TO ILLUMINATE IN THE FLIGHT DECK ?", "A CONDITIONED AIR OVERHEAT IN THE PASSENGER OR CREW AIR DUCT (>212F)",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 51 ,  5  ,  "IS THE NOSE CONE PRESSURIZED ?", "YES - SLIGHT PRESSURIZED TO MAINTAIN POSSITIVE VENTILATION DURING FLIGHT.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 52 ,  5  ,  "HOW CAN AIR TO THE PILOTS BE RE-DIRECTED ?", "BY SLIDING THE CREW DUCT LEVER TO THE UPPER OR LOWER POSITION (WINDSHIELD OR FOOT)",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 53 ,  5  ,  "FOR NORMAL OPERATION OF THE AIR CONDITIONING CONTROL PANEL,  WHAT IS REQUIRED ?", "THE CREW MODE SELECTOR ON THE PRESSURIZATION PANEL MUST BE IN THE  NORM  POSITION.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 54 ,  6  ,  "WHAT IS THE MAX FUEL CAPACITY OF THE  FALCON 900EX ?", "21,000 LBS) ",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 55 ,  6  ,  "WHAT ELECTRICAL SOURCE POWERS THE FUELING PANEL AND VENT VALVES ?", "THE BATTERY BUS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 56 ,  6  ,  "WHAT IS THE MAXIMUM PRESSURE ALLOWED FROM THE FUELING TRUCK ?", "50 PSI",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 57 ,  6  ,  "HOW ARE THE FUEL PUMPS POWERED ?", "THEY ARE A/C POWERED FROM THEIR OWN INTERNAL DC TO AC INVERTED POWERED PUMPS.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 58 ,  6  ,  "ILLUMINATION OF  FUEL 1,  FUEL 2,  OR FUEL 3  LIGHTS INDICATES WHAT ?", "FUEL PRESSURE IS LOW IN THE RESPECTIVE FUEL SUPPLY LINE",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 59 ,  6  ,  "THE XTK TRANSFER VALVE IS ACTUATED HOW ?", "WITH FUEL PRESSURE",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 60 ,  6  ,  "HOW ARE THE FUEL TANKS PRESSURIZED ?", "FROM #1 AND #2 ENGINE BLEED AIR",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 61 ,  6  ,  "CAN FUEL BE TRANFERED FROM WING TO WING ?", "YES, WITH XTK AND 1-3 MOTIVE FLOW",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 62 ,  6  ,  "WHAT IS THE MAXIMUM WING IMBALANCE LIMIT ?", "THERE IS NO LIMITS FOR THIS.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 63 ,  6  ,  "IS FUEL ANTI-ICE ADDITIVE REQUIRED FOR THIS AIRCRAFT ?", "NO",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 64 ,  6  ,  "IS IT POSSIBLE TO FUEL OVER-WING ?", "YES - THESE ARE SEPARATE KEYS TO UN-LOCK THE CAPS THOUGH",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 65 ,  6  ,  "WHAT ELSE IS REQUIRED TO OVERWING FUEL ?", "YOU NEED ELECTRICAL POWER FOR CONTROL OF THE CROSSFEED SWITCHES,  FUEL PUMPS,  AND MONITORING THE FUEL GUAGES.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 66 ,  6  ,  "AFTER PUSHING THE  TEST  BUTTON ON THE FUELING PANEL WHAT SHOULD OCCUR ?", "FUELING SHOULD STOP WITHING 5 SECONDS - IT TESTS THE AUTOMATIC STOOP SYSTEM.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 67 ,  6  ,  "WHEN THE FUELING PANEL DOOR IS OPENED AND THE  STOP REFUELING  LIGHT IS ON WHAT DOES THIS MEAN ?", "THE VENT VALVES ARE STILL CLOSED",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 68 ,  6  ,  "WHEN THE VENT VALVE LEVER IS RELEASED WHAT HAPPENS ?", "THE TANKS DE-PRESSURIZE AND THE FUELING OK  LIGHT WILL ILLUMINATE ON THE PANEL.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 69 ,  6  ,  "HOW ARE THE FEEDER TANKS RE-FUELED BY GRAVITY ?", " "             ,0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 70 ,  6  ,  "WHAT DO THE  LOW FUEL 1,  2 OR 3   INDICATE ?", "FUEL IS DOWN TO 200 LBS IN THE RESPECTIVE TANK.",0)');
      await db.execute('INSERT INTO Questions VALUES ( 71 ,  6  ,  "" ,"",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 72 ,  6  ,  "WHAT DOES THE  FUELING  LIGHT INDICATE ON THE WARNING PANEL ?", "A VENT VALVE NOT CLOSED,  REFUELING VALVE NO CLOSED,  FUEL ACCESS DOOR NOT CLOSED,  DEFUELING OR GRAVITY FUELING  SW  ON  VENT VALVE LEVER NOT RAISED,  NO B2 BUS POWER.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 73 ,  7  ,  "WHAT IS THE DIFFERENCE BETWEEN AIR CONDITIONING AND PRESSURIZATION SYSTEMS ?", "AIR CONDITIONING - HOW THE AIR GETS DISTRIBUTED TO OCCUPIED AREAS" || char(10) ||"PRESSURIZATION - HOW THE AIR IS REGULATED OUT OF THESE AREAS TO PROVIDE A PRESSURIZED CABIN.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 74 ,  7  ,  "WHAT AREAS ARE PRESSURIZED IN THE F900EX ?", "THE OCCUPIED AREAS,  THE BAGGAGE COMPARTMENT AND THE NOSE CONE.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 75 ,  2  ,  "WHAT IS THE MAX SPEED AND PRESSURE DIFFERENTIAL WITH A CRACKED WINDSCREEN ?", "230 KIAS AND 7.5 PSI DIFF",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 76 ,  2  ,  "WHAT IS THE MAX SPEED FOR USE OF WINDSHIELD WIPERS ?", "215",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 77 ,  2  ,  "WHAT IS THE MAX SPEED FOR GEAR EXTENTION / RETRACTION ?", "190 KIAS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 78 ,  2  ,  "WHAT IS THE MAX SPEED GEAR EXTENDED ?", "245 KIAS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 79 ,  2  ,  "WHAT IS THE MAXIMUM DEMONSTRATED CROSS WIND ", "30",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 80 ,  2  ,  "WHAT IS THE MAX TIRE ROTATION SPEED ?", "195 (225 mph TIRES)",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 81 ,  7  ,  "WHAT IS THE MAXIMUM CABIN DIFFERENTIAL (PRESSURE RELIEF SETTING ) ?", "9.6 PSI",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 82 ,  7  ,  "WHAT IS THE NORMAL PRESSURE DIFFERENTIAL MAX", "9.3 PSI",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 83 ,  7  ,  "WHAT ARE THE 2 MODES OF PRESSURIZATION OPERATIONS ?", "AUTOMATIC AND MANUAL",0)');
      await db.execute('INSERT INTO Questions VALUES ( 84 ,  7  ,  "","",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 85 ,  7  ,  "IF THE  DUMP  SWITCH IS USED TO DEPRESSURIZE THE CABIN WHAT ALTITUDE WILL THE CABIN STABILIZE AT ?", "14, 500  +/- 500",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 86 ,  7  ,  "WHAT HOLDS THE OUTFLOW VALVES  OPEN  ON THE GROUND ?", "VACUUM PRODUCED BY A JET PUMP SUPPLIED BY H.P. AIR FROM THE APU,  ENG #1 OR ENG #2",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 87 ,  7  ,  "IN THE  MANUAL  MODE WHAT CONTROLS THE RATE OF CLIMB / DECENT ?", "THE UP-DN KNOB ON THE EMMERGENCY PRESSURIZATION CONTROLLER.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 88 ,  7  ,  "WHAT IS THE PHASE 1 PROCEDURE OF ANY CABIN MALFUNCTION / LOSS ?", "O2 MASKS ON"|| char(10) ||"ESTABLISH COCKPIT INTERPHONE COM",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 89 ,  8  ,  "HOW ARE THE F900EX FLIGHT CONTROLS ACTUATED ?", "THEY ARE HYDRAULICALLY BOOSTED,  MANUALLY BACKED UP IN THE EVENT OF HYD FAILURE.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 90 ,  8  ,  "HOW IS AILERON AND RUDDER TRIM ACTUATED ?", "INITIATED BY ELECTRIC MOTORS ACTUATE HYDRAULIC OPERATION",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 91 ,  8  ,  "HOW IS THE HORIZONTAL STAB ACTUATED ?", "TRIM IS ELECTRICALLY OPERATED",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 92 ,  8  ,  "HOW ARE ALL OF THE SECONDARY FLIGHT CONTROLS ACTUATED ?", "THEY ARE ELECTRICALLY CONTROLLED AND HYDRAULICALLY ACTUATED.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 93 ,  8  ,  "IN THE EVENT OF HYDRAULIC FAILURE WHAT IS THE LIMITING SPEED FOR INCREASED EFFICIENCY ?", "BELOW 260 KIAS, .76M",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 94 ,  8  ,  "WHAT MOTORS MOVE THE STAB ?", "THE NORMAL AND EMERGENCY TRIM MOTORS PROVIDE CONTROL",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 95 ,  8  ,  "WHAT IS  ARTHUR Q  ?", "IT IS THE AFU (ARTIFICIAL FEEL UNIT) PROVIDING FEEDBACK PRESSURE TO THE CONTROL INPUT BASED ON SPEED.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 96 ,  8  ,  "WHAT FLIGHT CONTROLS INCORPORATE ARTHUR Q SYSTEM ?", "THE ELEVATORS AND AILERONS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 97 ,  8  ,  "WHAT IS THE LIMITATION ON EXTENDING AIR BRAKES IN FLIGHT ?", "AIR BRAKES MUST NOT BE EXTENDED BELOW 300 AGL",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 98 ,  8  ,  "WHAT TRIGGERS AUTOMATIC OUTBOARD SLAT EXTENSION FOR STALL PROTECTION ?", "LEFT AND RIGHT STALL VANES SENSING CRITICAL ANGLES OF ATTACK",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 99 ,  8  ,  "WHAT ITEMS TRIGGER A  T.O. CONFIG WARNING LIGHT ?", "FLAPS > 22 DEG S,  SLAT HANDLE  CLEAN  POSITION,  SLATS NOT FULLY EXTENDED,  AIR BRAKES NO RETRACTED,  STAB NOT IN GREEN RANGE,  PARKING BRAKE  ON ",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 100  ,  8  ,  "WHAT IS THE AIRSPEED LIMITATION WITH THE  AUTOSLAT  LIGHT ILLUMINATED ?", "270 KIAS AND BELOW",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 101  ,  9  ,  "WHAT HYDRAULIC SYSTEM OPERATES THE LANDING GEAR ?", "THE #1 SYSTEM",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 102  ,  9  ,  "HOW MANY WAYS CAN THE LANDING GEAR BE OPERATED ?", "ELECTRIC/HYDRAULIC"|| char(10) ||"MANUAL/HYDRAULIC"|| char(10) ||"MANUAL/GRAVITY",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 103  ,  9  ,  "WHAT IS THE RECOMMENDED MINIMUM AIRSPEED TO LOWER THE GEAR IN MANUAL/GRAVITY MODE ?", "160 KIAS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 104  ,  9  ,  "WHAT HOLDS THE GEAR IN THE EXTENDED POSITION ?", "MECHANICAL LOCKDOWN WITH CONTINUOUS HYDRAULIC PRESSURE BACKUP",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 105  ,  9  ,  "WHAT HOLDS THE LANDING GEAR UP IN POSITION ?", "MECHANICAL UPLOCKS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 106  ,  9  ,  "HOW MANY AIR / GROUND PROXIMITY SWITCHES ARE ON EACH GEAR ?", "6 - TOTAL" || char(10) ||"2 PER GEAR",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 107  ,  9  ,  "WHAT DO THE 3  RED  GEAR WARNING LIGHTS INDICATE ?", "2 - LATERAL LIGHTS ARE FOR MAIN GEAR DOORS NOT CLOSED,  THE CENTER LIGHT FOR THE NOSE GEAR POSITION INDICATION.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 108  ,  9  ,  "ON RETRACTION WHAT STOPS THE WHEELS FROM ROTATING ?", "AUTOMATIC BRAKING (SNUBBING) OCCURS.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 109  ,  9  ,  "ON RETRACTION WHAT PREVENTS THE NOSE WHEELS FROM RETRACTING OFF CENTER ?", "THEY ARE SELF-CENTERING DURING RETRACTION AND NOSE WHEEL STEERING VALVE SHUTS OFF TO PREVENT INADVERTENT STEERING IN FLIGHT ."            ,0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 110  ,  9  ,  "HOW IS THE GEAR PROTECTED AGAINST INADVERTENT RETRACTION ON THE GROUND ?", "BY A SPRING LOADED LOCKING PIN HOLDS THE HANDLE DOWN.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 111  ,  9  ,  "WHAT OCCURS WHEN THE  GEAR PULL  HANDLE NEXT TO THE NORMAL GEAR CONTROL HANDLE IS PULLED ?", "IT MECHANICALLY ACTUATES A HYDRAULIC SELECTOR VALVE IN THE EMERGENCY EXTENSION SYSTEM TO DIRECT #1 HYD SYSTEM PRESSURE  TO UNLOCK THE GEARS AND DOORS FOR EXTENSION ONLY."            ,0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 112  ,  9  ,  "WHAT HAPPENS WHEN YOU STOW THE HANDLE ?", "IT RESTORES ELECTRICAL SEQUENCING AND REPOSITIONS THE SELECTOR VALVE PRIOR TO NORMAL GEAR OPERATION.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 113  ,  9  ,  "WHAT HYDRAULIC SYSTEM PROVIDES POWER TO THE #1 BRAKE SYSTEM ?", "THE #1 HYDRAULIC SYSTEM.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 114  ,  9  ,  "WHICH BRAKE SYSTEMS PROVIDE ANTI-SKID PROTECTION ?", "ONLY THE #1 SYSTEM",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 115  ,  9  ,  "WHAT IS THE MAXIMUM BRAKE PRESSURE AVAILABLE IN SYSTEMS #1 AND #2 ?", "SYSTEM #1 = 1600 PSI"|| char(10) ||"SYS #2 = 800 PSI",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 116  ,  9  ,  "HOW MUCH PRESSURE IS APPLIED TO THE BRAKES WITH THE FIRST DETENT OF THE PARKING BRAKES ?", "390 PSI",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 117  ,  10 ,  "WHAT IS REQUIRED TO START THE APU ?", "THE BATTERY VOLTAGE > 22 VOLTS"|| char(10) ||"THE BUS TIE --> TIED"|| char(10) ||"#2 FUEL BOOST PUMP - ST-BY",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 118  ,  10 ,  "WHAT OBSERVATION IS ESSENTIAL PRIOR TO TURNING THE APU BLEED SW ON ?", "ENSURE THE E & E BAY DOOR IS CLOSED. THE ECU EXHAUST WILL DAMAGE THE DOOR IF OPEN.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 119  ,  10 ,  "WHAT IS THE MAXIMUM LOAD ON THE APU GENERATOR ?", " 300 AMPS , 350 MOMENTARY.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 120  ,  10 ,  "ARE THE APU STARTER / GENERATORS INTERCHANGEABLE WITH THE ENGINES ?", "YES, SAME UNITS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES ( 121  ,  10 ,  "CAN THE APU BE STARTED USING A GROUND POWER UNIT, IF BATTERIES ARE BELOW MAKE OR BREAK LEVEL ?", " YES, YOU CAN GPU START AND CHARGE THE BATTERIES WITH THE APU.",0)');
      await db.execute(
          'INSERT INTO Questions VALUES (122 , 11,	"ALL ENGINES OUT ","1. MINI LOAD - ON"|| char(10) ||"2. COMM-VHF1 / ATC1"|| char(10) ||"3. START ENVELOPE AIRSPEED"|| char(10) ||"4. ATTEMPT RELIGHT ALL 3 ",0)');
      await db.execute(
          'INSERT INTO Questions VALUES (123 , 11,	"EMERGENCY EVACUATION ","1. PARKING BRAKE SET"|| char(10) ||"2. ATC - ADVISE / NOTIFY"|| char(10) ||"3. PASSENGERS - INSTRUCT ",0)');
      await db.execute(
          'INSERT INTO Questions VALUES (124 , 11,	"ENGINE FIRE ","1. PWR LEVER - CUTOFF"|| char(10) ||"2. FUEL SHUT-OFF SW - ACTUATED"|| char(10) ||" 3. AIRSPEED BELOW 250"|| char(10) ||"4. DISCH SW - POS 1"|| char(10) ||"5. IF FIRE CONT - DISC SW POSITION 2. ",0)');
      await db.execute(
          'INSERT INTO Questions VALUES (125 , 11,	"INADVERTENT THRUST REVERSER DEPLOYMENT ","1. ENGINE 2 - IDLE"|| char(10) ||"2. AIRSPEED 180 OR LESS",0)');
      await db.execute(
          'INSERT INTO Questions VALUES (126 , 11,	"APU FIRE ","1. APU MASTER PUSH BUTTON - OFF"|| char(10) ||"2. WAIT FOR 10 SECONDS"|| char(10) ||"3. FIRE APU PUSH BUTTON - PUSH",0)');
      await db.execute(
          'INSERT INTO Questions VALUES (127 , 11,	"AIR CONDITIONING SMOKE","1. 02 MASKS / INTERPHONE  / GOGGLES - 100% AND DONNED"|| char(10) ||"2. NO SMOKING / FSB - ON"|| char(10) ||"3. O2 CONTROLLER - OVERRIDE"|| char(10) ||"4. PASSENGER 02 - USE",0)');
      await db.execute(
          'INSERT INTO Questions VALUES (128 , 11,	"RAPID DEPRESSURIZATION","1. 02 MASKS - 100% DONNED"|| char(10) ||"2. MIC INTERPHONE - MASK & TEST"|| char(10) ||"3. NS/FSB SIGNS - ON"|| char(10) ||"4. PASS 02 OVERRIDE AND USE"|| char(10) ||"5. EMERGENCY DECENT - INITIATE",0)');
      await db.execute(
          'INSERT INTO Questions VALUES (129 , 11,	"EMERGENCY DECENT","1. AP-DISENGAGE"|| char(10) ||"2. POWER  -  IDLE"|| char(10) ||"3.  AIRBRAKES - POSITION 2"|| char(10) ||"4. DESCENT AT Vmo/Mmo"|| char(10) ||"5. ATC - SQ 7700",0)');

      // Questions Insert Scripts

      var help = """HELP FILES
GETTING STARTED

Welcome to VrefPRO. We have organized your review into SYSTEMS , QUESTIONS and ANSWER formats. Additionally we have a DETAILS section which offers an area for notes, or a more expanded explanations of the Question or Answer selected.

Once on the main landing page, simply TAP the screen to advance to the SYSTEMS page.  From here you select one or more systems to review by filling the check box next to the SYSTEM.

The SYSTEM menu bar, top left of the page, allows you to select and add new SYSTEMS to your data. Once added you can ADD / MODIFY / DELETE new data to that system.

**  note: PREVENT DATA LOSS ! When you add new systems and information in the QUESTION / ANSWER/ DETAIL data areas, remember to back up your program to the cloud. We can restore your original program if lost, but the custom data is yours and we have no way of copying the data you enetered.

Press the ""CONTINUE"" bar button to advance to the QUESTION / ANSWER area.

QUESTIONS / ANSWERS / DETAILS

The SYSTEM(s) you check marked carry forward to this area of the program. The current QUESTION number is shown 
on the top left of the QUESTION block. The current Q:Number out of Total Q:Number is displayed on the top right 
of the Question block.

To view the ANSWER to the question simply TAP on the Question block area. Tap once more to go back to your Question. 
To advance to the next QUESTION swipe with your finger from left to right, to go backwards swipe right to left.

Use the DOT STACK menu located on the top right of the screen to access the ADD / MODIFY / DELETE app functions.

Selecting "ADD" will enable you to enter on a blank QUESTION, ANSWER and DETAIL area in the SYSTEM you are currently in, 
adding it to the end of the file. Selecting "MODIFY" will enable you to append the current record you are on. In both cases 
complete the process with the Green check located at the bottom of the page. While in the "EDIT" mode clicking 
on the "?" icon center bottom of screen takes you to the detail page. This detail page is for further explanation 
you may have for a question or answer for better understanding. Also while in the edit mode, you are able to add
graphics pictures from your devices gallery, or actuall use your devices camera to take a picture and store it in the
details for future reference. Make sure to click "SAVE" after your photo and when it returns you to the Q & A page you
are adding/modifying, click the check-mark to complete the save process.

Selecting ""DELETE"" will prompt an ""are you sure . . ?"" dialogue, agreeing with that will permanently erase this question / answer / detail.""";

      var disclaimer = """DISCLAIMER

.Welcome to the VrefPRO Study App. 

We have designed our APP to provide fellow aviators an easy to use mobile 
learning tool to access facts and information about your aircraft in hopes 
to achieve a higher level of knowledge. It is an excellent preparation for 
upcoming recurrent events, testing, transitioning and upgrading. 

We hope you''ll find this tool beneficial to your education and progress.

VrefPRO, like all "for training only" information, is not intended to replace 
your company's manuals, training aids, or manufacturer's data. We only provide 
a platform to allow studying and referencing your aircraft data easy to do.

Because it is impossible to cover everything you would like to know, nor is it 
our intention to do so, and because the information changes so regularly;

WE ACCEPT NO RESPONIBILITY FOR THE CONTENT in this application or for the 
consequences of any actions taken on the basis of the information provided 
herein, and ,

WE DO NOT GUARANTEE OR WARRANT THAT THE INFORMATION WITHIN THIS APP IS CURRENT, 
ACCURATE OR COMPLETE.


THIS IS FOR TRAINING PURPOSES ONLY and it is for that reason you are able to add, 
modify or delete any or all data you wish to. You alone are responsible for the 
accuracy of all data in the app. 

We hope you find our program beneficial.
Fly Safe
""";

      var about = """About text here...""";

      await db.insert("OtherDetails",
          {"id": "1", "help": help, "disclaimer": disclaimer, "about": about});
    });
  }

  planeCategories(PlaneCategories newClient) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT Into PlaneCategories (id,name)"
        "VALUES (?,?)",
        [newClient.id, newClient.name]);
    return raw;
  }

  addImage(ImageModel modelImage) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT Into Image (id,question_id,image) VALUES (?,?,?)",
        [modelImage.id, modelImage.question_id, modelImage.image]);
    return raw;
  }

  newClient(QuestionDetails newClient) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT Into Questions (system_id,question,answer,description)"
        "VALUES (?,?,?,?)",
        [
          newClient.systemId,
          newClient.question,
          newClient.answer,
          newClient.description,
        ]);
    return raw;
  }

  newSystemList(SystemListModel newClient) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT Into SystemList (plane_id,name,status)"
        "VALUES (?,?,?)",
        [newClient.planeId, newClient.name, newClient.status]);
    return raw;
  }

  updateClient(String q, String a, String d, int id) async {
    print("Question Id update ${id}");
    final db = await database;
    var res = await db!.update(
        "Questions", {"question": q, "answer": a, "description": d},
        where: "id = ?", whereArgs: [id]);
    return res;
  }

  deleteImageClient(var id) async {
    final db = await database;
    db!.rawDelete("DELETE image FROM Questions WHERE id=$id");
  }

  updateSystemList(SystemListModel newClient) async {
    final db = await database;
    var res = await db!.update("SystemList", newClient.toJson(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  Future<List<Map>> getAllSystemListMap() async {
    final db = await database;
    List<Map> list = (await db!.rawQuery('SELECT * FROM SystemList'));
    return list;
  }

  Future getAllImages() async {
    final db = await database;
    var list = (await db!.rawQuery('SELECT * FROM Image'));
    print(list);
    return list;
  }

  Future getDescription(var id) async {
    final db = await database;
    var list =
        (await db!.rawQuery('SELECT description FROM Questions WHERE id=$id'));
    print(list);
    return list;
  }

  Future<List<Map>> getAllClientsMap() async {
    final db = await database;
    List<Map> list = (await db!.rawQuery('SELECT * FROM Questions'));
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db!.delete("Questions", where: "id = ?", whereArgs: [id]);
  }

  deleteClientQuestionImage(int id) async {
    final db = await database;
    return db!.delete("Image", where: "question_id = ?", whereArgs: [id]);
  }

  deleteImage(String image) async {
    print("image");
    print(image);
    final db = await database;
    return db!.delete("Image", where: "image = ?", whereArgs: [image]);
  }

  deleteAll() async {
    final db = await database;
    db!.rawDelete("Delete * from Questions");
  }

  Future<List<QuestionDetails>> getAllQuestions(int id) async {
    final db = await database;
    var res =
        await db!.query("Questions", where: "system_id = ?", whereArgs: [id]);
    List<QuestionDetails> list = res.isNotEmpty
        ? res.map((c) => QuestionDetails.fromJson(c)).toList()
        : <QuestionDetails>[
            QuestionDetails(
              systemId: id,
              question: 'Please add questions!',
              answer: "Please add questions!",
              description: "",
            ),
          ];
    return list;
  }

  Future<List<QuestionDetails>> getMultipleIds1(List<int> ids) async {
    final db = await database;
    var res =
        await db!.query("Questions", where: "system_id IN (${ids.join(",")})");
    List<QuestionDetails> list = res.isNotEmpty
        ? res.map((c) => QuestionDetails.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<List<SystemListModel>> getAllSystemList(int planeId) async {
    final db = await database;
    var res = await db!
        .query("SystemList", where: "plane_id = ?", whereArgs: [planeId]);
    List<SystemListModel> list = res.isNotEmpty
        ? res.map((c) => SystemListModel.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<List<OtherDetails>> getOtherDetails() async {
    final db = await database;
    var res = await db!.query("OtherDetails");
    print(res);
    List<OtherDetails> list =
        res.isNotEmpty ? res.map((c) => OtherDetails.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<PlaneCategories>> getPlaneCategories() async {
    final db = await database;
    var res = await db!.query("PlaneCategories");
    List<PlaneCategories> list = res.isNotEmpty
        ? res.map((c) => PlaneCategories.fromJson(c)).toList()
        : [];
    return list;
  }

  void updateImage() {}
}
