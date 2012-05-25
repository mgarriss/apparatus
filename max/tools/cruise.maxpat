{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 6,
			"minor" : 0,
			"revision" : 4
		}
,
		"rect" : [ 297.0, 51.0, 640.0, 480.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"boxes" : [ 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-29",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 489.0, 364.0, 34.0, 20.0 ],
					"text" : "pvar"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-28",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "int", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 331.0, 164.0, 50.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-26",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 398.0, 387.0, 34.0, 20.0 ],
					"text" : "print"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-25",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 398.0, 314.0, 61.0, 20.0 ],
					"text" : "pvar data"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-20",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 243.0, 229.0, 114.0, 20.0 ],
					"text" : "prepend insert data"
				}

			}
, 			{
				"box" : 				{
					"comment" : "",
					"id" : "obj-19",
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 243.0, 154.0, 25.0, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-14",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 469.0, 209.0, 33.0, 18.0 ],
					"text" : "next"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-7",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 185.0, 370.0, 34.0, 20.0 ],
					"text" : "print"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-2",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "bang", "bang" ],
					"patching_rect" : [ 243.0, 297.0, 46.0, 20.0 ],
					"save" : [ "#N", "qlist", ";", "#X", "insert", 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 12, 13, 14, 16, 17, 18, 19, 20, 22, 24, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, ";", ";", "#X", "insert", 38, ";", ";", "#X", "insert", 39, ";", ";", "#X", "insert", 40, ";", ";", "#X", "insert", 41, ";", ";", "#X", "insert", 40, ";", ";", "#X", "insert", 39, ";", ";", "#X", "insert", 38, ";", ";", "#X", "insert", 37, ";", ";", "#X", "insert", 36, ";", ";", "#X", "insert", 35, ";", ";", "#X", "insert", 34, ";", ";", "#X", "insert", 33, ";", ";", "#X", "insert", 32, ";", ";", "#X", "insert", 33, ";", ";", "#X", "insert", "dude", "man", ";", ";", "#X", "insert", "list", "dude", "man", ";", ";", "#X", "insert", "symbol", "dude", "man", ";", ";", "#X", "insert", "symbol", "dude", "man", ";", ";", "#X", "insert", "symbol", "dude", "man", ";", ";", "#X", "insert", 1, 2, 3, 4, ";", ";", "#X", "insert", 1, 2, 3, 4, ";", ";", "#X", "insert", 0, "dude", "man", ";", ";", "#X", "insert", "dude", "man", "jow", ";", ";", "#X", "insert", "$0", "lkdf", ";", ";", "#X", "insert", "$0", 1, ";", ";", "#X", "insert", "$0", 2, ";", ";", "#X", "insert", "$0", 4, ";", ";", "#X", "insert", "$0", 5, ";", ";", "#X", "insert", "$0", 6, ";", ";", "#X", "insert", "$0", 7, ";", ";", "#X", "insert", "$0", 8, ";", ";", "#X", "insert", "$0", 6, ";", ";", "#X", "insert", "$0", 4, ";", ";", "#X", "insert", "$0", 2, ";", ";", "#X", "insert", "$0", 1, ";", ";", "#X", "insert", "$0", -1, ";", ";", "#X", "insert", "$0", -3, ";", ";", "#X", "insert", "$0", -4, ";", ";", "#X", "insert", "$0", -5, ";", ";", "#X", "insert", "$0", -7, ";", ";", "#X", "insert", "$0", -9, ";", ";", "#X", "insert", "$0", -10, ";", ";", "#X", "insert", "$0", -11, ";", ";", "#X", "insert", "$0", -12, ";", ";", "#X", "insert", "$0", -13, ";", ";", "#X", "insert", "$0", -12, ";", ";", "#X", "insert", "$0", -11, ";", ";" ],
					"text" : "qlist"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-14", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-19", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-20", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-28", 0 ]
				}

			}
 ],
		"dependency_cache" : [  ]
	}

}
