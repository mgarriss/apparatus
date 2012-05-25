{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 6,
			"minor" : 0,
			"revision" : 4
		}
,
		"rect" : [ 785.0, 44.0, 240.0, 404.0 ],
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
					"comment" : "",
					"id" : "obj-99",
					"maxclass" : "outlet",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 99.25, 333.0, 25.0, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-98",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 122.25, 260.0, 57.0, 20.0 ],
					"text" : "zl slice 1"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-97",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "int", "clear" ],
					"patching_rect" : [ 45.0, 291.0, 53.0, 20.0 ],
					"text" : "t 1 clear"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-94",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 45.0, 260.0, 52.0, 20.0 ],
					"text" : "select 1"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-93",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 45.0, 227.5, 55.0, 20.0 ],
					"text" : "== 1024"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-92",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 4,
					"outlettype" : [ "int", "", "", "int" ],
					"patching_rect" : [ 45.0, 194.0, 73.0, 20.0 ],
					"text" : "counter"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-91",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "next" ],
					"patching_rect" : [ 45.0, 143.0, 50.0, 20.0 ],
					"text" : "t b next"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-65",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 134.5, 217.5, 32.5, 20.0 ],
					"text" : "t b l"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-63",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 45.0, 110.0, 56.0, 20.0 ],
					"text" : "delay #1"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-58",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 99.25, 67.0, 32.5, 20.0 ],
					"text" : "t b l"
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
					"patching_rect" : [ 122.25, 133.0, 97.0, 20.0 ],
					"text" : "prepend insert 0"
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
					"patching_rect" : [ 99.25, 21.0, 25.0, 25.0 ]
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
					"patching_rect" : [ 134.5, 191.0, 46.0, 20.0 ],
					"save" : [ "#N", "qlist", ";", "#X", "insert", 0, 558, ";", ";", "#X", "insert", 0, 559, ";", ";", "#X", "insert", 0, 560, ";", ";", "#X", "insert", 0, 561, ";", ";", "#X", "insert", 0, 562, ";", ";", "#X", "insert", 0, 561, ";", ";", "#X", "insert", 0, 560, ";", ";", "#X", "insert", 0, 559, ";", ";", "#X", "insert", 0, 560, ";", ";", "#X", "insert", 0, 561, ";", ";", "#X", "insert", 0, 560, ";", ";", "#X", "insert", 0, 559, ";", ";", "#X", "insert", 0, 558, ";", ";", "#X", "insert", 0, 557, ";", ";", "#X", "insert", 0, 556, ";", ";", "#X", "insert", 0, 555, ";", ";", "#X", "insert", 0, 554, ";", ";", "#X", "insert", 0, 553, ";", ";", "#X", "insert", 0, 552, ";", ";", "#X", "insert", 0, 551, ";", ";", "#X", "insert", 0, 550, ";", ";", "#X", "insert", 0, 549, ";", ";", "#X", "insert", 0, 548, ";", ";", "#X", "insert", 0, 547, ";", ";", "#X", "insert", 0, 546, ";", ";", "#X", "insert", 0, 545, ";", ";", "#X", "insert", 0, 544, ";", ";", "#X", "insert", 0, 543, ";", ";", "#X", "insert", 0, 542, ";", ";", "#X", "insert", 0, 541, ";", ";", "#X", "insert", 0, 540, ";", ";", "#X", "insert", 0, 539, ";", ";", "#X", "insert", 0, 538, ";", ";", "#X", "insert", 0, 537, ";", ";", "#X", "insert", 0, 536, ";", ";", "#X", "insert", 0, 535, ";", ";", "#X", "insert", 0, 534, ";", ";", "#X", "insert", 0, 533, ";", ";", "#X", "insert", 0, 532, ";", ";", "#X", "insert", 0, 531, ";", ";", "#X", "insert", 0, 530, ";", ";", "#X", "insert", 0, 529, ";", ";", "#X", "insert", 0, 528, ";", ";", "#X", "insert", 0, 527, ";", ";", "#X", "insert", 0, 526, ";", ";", "#X", "insert", 0, 525, ";", ";", "#X", "insert", 0, 524, ";", ";", "#X", "insert", 0, 523, ";", ";", "#X", "insert", 0, 522, ";", ";", "#X", "insert", 0, 521, ";", ";", "#X", "insert", 0, 520, ";", ";", "#X", "insert", 0, 519, ";", ";", "#X", "insert", 0, 518, ";", ";", "#X", "insert", 0, 517, ";", ";", "#X", "insert", 0, 516, ";", ";", "#X", "insert", 0, 515, ";", ";", "#X", "insert", 0, 514, ";", ";", "#X", "insert", 0, 513, ";", ";", "#X", "insert", 0, 512, ";", ";", "#X", "insert", 0, 511, ";", ";", "#X", "insert", 0, 510, ";", ";", "#X", "insert", 0, 509, ";", ";", "#X", "insert", 0, 508, ";", ";", "#X", "insert", 0, 507, ";", ";", "#X", "insert", 0, 506, ";", ";", "#X", "insert", 0, 505, ";", ";", "#X", "insert", 0, 504, ";", ";", "#X", "insert", 0, 503, ";", ";", "#X", "insert", 0, 502, ";", ";", "#X", "insert", 0, 501, ";", ";", "#X", "insert", 0, 500, ";", ";", "#X", "insert", 0, 499, ";", ";", "#X", "insert", 0, 498, ";", ";", "#X", "insert", 0, 497, ";", ";", "#X", "insert", 0, 496, ";", ";", "#X", "insert", 0, 495, ";", ";", "#X", "insert", 0, 494, ";", ";", "#X", "insert", 0, 493, ";", ";", "#X", "insert", 0, 492, ";", ";", "#X", "insert", 0, 491, ";", ";", "#X", "insert", 0, 490, ";", ";", "#X", "insert", 0, 489, ";", ";", "#X", "insert", 0, 488, ";", ";", "#X", "insert", 0, 487, ";", ";", "#X", "insert", 0, 486, ";", ";", "#X", "insert", 0, 485, ";", ";", "#X", "insert", 0, 484, ";", ";", "#X", "insert", 0, 483, ";", ";", "#X", "insert", 0, 481, ";", ";", "#X", "insert", 0, 480, ";", ";", "#X", "insert", 0, 479, ";", ";", "#X", "insert", 0, 478, ";", ";", "#X", "insert", 0, 476, ";", ";", "#X", "insert", 0, 474, ";", ";", "#X", "insert", 0, 473, ";", ";", "#X", "insert", 0, 471, ";", ";", "#X", "insert", 0, 470, ";", ";", "#X", "insert", 0, 467, ";", ";", "#X", "insert", 0, 465, ";", ";", "#X", "insert", 0, 462, ";", ";", "#X", "insert", 0, 459, ";", ";", "#X", "insert", 0, 456, ";", ";", "#X", "insert", 0, 453, ";", ";", "#X", "insert", 0, 449, ";", ";", "#X", "insert", 0, 448, ";", ";", "#X", "insert", 0, 446, ";", ";", "#X", "insert", 0, 447, ";", ";", "#X", "insert", 0, 449, ";", ";", "#X", "insert", 0, 450, ";", ";", "#X", "insert", 0, 451, ";", ";", "#X", "insert", 0, 452, ";", ";", "#X", "insert", 0, 453, ";", ";", "#X", "insert", 0, 454, ";", ";", "#X", "insert", 0, 455, ";", ";", "#X", "insert", 0, 459, ";", ";", "#X", "insert", 0, 467, ";", ";", "#X", "insert", 0, 474, ";", ";", "#X", "insert", 0, 479, ";", ";", "#X", "insert", 0, 483, ";", ";", "#X", "insert", 0, 486, ";", ";", "#X", "insert", 0, 488, ";", ";" ],
					"text" : "qlist"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-58", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-19", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-65", 0 ],
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
					"destination" : [ "obj-20", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-58", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-63", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-58", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-91", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-63", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-63", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-65", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-98", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-65", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-91", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-92", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-91", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-93", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-92", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-94", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-93", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-97", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-94", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-97", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-92", 3 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-97", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-99", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-98", 1 ]
				}

			}
 ],
		"dependency_cache" : [  ]
	}

}
