(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start")(export "main") call $r3_poke call $app_f)
  (func $r3_poke
    i32.const 0 f64.const 505.0 f64.store
    i32.const 8 f64.const 506.1 f64.store
    i32.const 16 f64.const 507.2 f64.store
    i32.const 24 f64.const 508.3 f64.store
    i32.const 32 f64.const 509.4 f64.store
    i32.const 40 f64.const 510.5 f64.store
    i32.const 48 f64.const 511.6 f64.store
    i32.const 56 f64.const 512.7 f64.store
    i32.const 64 f64.const 513.8 f64.store
    i32.const 72 f64.const 514.9 f64.store
    i32.const 80 f64.const 515.10 f64.store
    i32.const 88 f64.const 516.11 f64.store
    i32.const 96 f64.const 517.12 f64.store
    i32.const 104 f64.const 518.13 f64.store
    i32.const 112 f64.const 519.14 f64.store
    i32.const 120 f64.const 520.15 f64.store
    i32.const 128 f64.const 521.16 f64.store
    i32.const 136 f64.const 522.17 f64.store
    i32.const 144 f64.const 523.18 f64.store
    i32.const 152 f64.const 524.19 f64.store
    i32.const 160 f64.const 525.20 f64.store
    i32.const 168 f64.const 526.21 f64.store
    i32.const 176 f64.const 527.22 f64.store
    i32.const 184 f64.const 528.23 f64.store
    i32.const 192 f64.const 529.24 f64.store
    i32.const 200 f64.const 530.25 f64.store
    i32.const 208 f64.const 531.26 f64.store
    i32.const 216 f64.const 532.27 f64.store
    i32.const 224 f64.const 533.28 f64.store
    i32.const 232 f64.const 534.29 f64.store
    i32.const 240 f64.const 535.30 f64.store
    i32.const 248 f64.const 536.31 f64.store
    i32.const 256 f64.const 537.32 f64.store
    i32.const 264 f64.const 538.33 f64.store
    i32.const 272 f64.const 539.34 f64.store
    i32.const 280 f64.const 540.35 f64.store
    i32.const 288 f64.const 541.36 f64.store
    i32.const 296 f64.const 542.37 f64.store
    i32.const 304 f64.const 543.38 f64.store
    i32.const 312 f64.const 544.39 f64.store
    i32.const 320 f64.const 545.40 f64.store
    i32.const 328 f64.const 546.41 f64.store
    i32.const 336 f64.const 547.42 f64.store
    i32.const 344 f64.const 548.43 f64.store
    i32.const 352 f64.const 549.44 f64.store
    i32.const 360 f64.const 550.45 f64.store
    i32.const 368 f64.const 551.46 f64.store
    i32.const 376 f64.const 552.47 f64.store
    i32.const 384 f64.const 553.48 f64.store
    i32.const 392 f64.const 554.49 f64.store
    i32.const 400 f64.const 555.50 f64.store
    i32.const 408 f64.const 556.51 f64.store
    i32.const 416 f64.const 557.52 f64.store
    i32.const 424 f64.const 558.53 f64.store
    i32.const 432 f64.const 559.54 f64.store
    i32.const 440 f64.const 560.55 f64.store
    i32.const 448 f64.const 561.56 f64.store
    i32.const 456 f64.const 562.57 f64.store
    i32.const 464 f64.const 563.58 f64.store
    i32.const 472 f64.const 564.59 f64.store
    i32.const 480 f64.const 565.60 f64.store
    i32.const 488 f64.const 566.61 f64.store
    i32.const 496 f64.const 567.62 f64.store
    i32.const 504 f64.const 568.63 f64.store
    i32.const 512 f64.const 569.64 f64.store
    i32.const 520 f64.const 570.65 f64.store
    i32.const 528 f64.const 571.66 f64.store
    i32.const 536 f64.const 572.67 f64.store
    i32.const 544 f64.const 573.68 f64.store
    i32.const 552 f64.const 574.69 f64.store
    i32.const 560 f64.const 575.70 f64.store
    i32.const 568 f64.const 576.71 f64.store
    i32.const 576 f64.const 577.72 f64.store
    i32.const 584 f64.const 578.73 f64.store
    i32.const 592 f64.const 579.74 f64.store
    i32.const 600 f64.const 580.75 f64.store
    i32.const 608 f64.const 581.76 f64.store
    i32.const 616 f64.const 582.77 f64.store
    i32.const 624 f64.const 583.78 f64.store
    i32.const 632 f64.const 584.79 f64.store
    i32.const 640 f64.const 585.80 f64.store
    i32.const 648 f64.const 586.81 f64.store
    i32.const 656 f64.const 587.82 f64.store
    i32.const 664 f64.const 588.83 f64.store
    i32.const 672 f64.const 589.84 f64.store
    i32.const 680 f64.const 590.85 f64.store
    i32.const 688 f64.const 591.86 f64.store
    i32.const 696 f64.const 592.87 f64.store
    i32.const 704 f64.const 593.88 f64.store
    i32.const 712 f64.const 594.89 f64.store
    i32.const 720 f64.const 595.90 f64.store
    i32.const 728 f64.const 596.91 f64.store
    i32.const 736 f64.const 597.92 f64.store
    i32.const 744 f64.const 598.93 f64.store
    i32.const 752 f64.const 599.94 f64.store
    i32.const 760 f64.const 600.95 f64.store
    i32.const 768 f64.const 601.96 f64.store
    i32.const 776 f64.const 602.97 f64.store
    i32.const 784 f64.const 603.98 f64.store
    i32.const 792 f64.const 604.99 f64.store
    i32.const 800 f64.const 605.0 f64.store
    i32.const 808 f64.const 606.1 f64.store
    i32.const 816 f64.const 607.2 f64.store
    i32.const 824 f64.const 608.3 f64.store
    i32.const 832 f64.const 609.4 f64.store
    i32.const 840 f64.const 610.5 f64.store
    i32.const 848 f64.const 611.6 f64.store
    i32.const 856 f64.const 612.7 f64.store
    i32.const 864 f64.const 613.8 f64.store
    i32.const 872 f64.const 614.9 f64.store
    i32.const 880 f64.const 615.10 f64.store
    i32.const 888 f64.const 616.11 f64.store
    i32.const 896 f64.const 617.12 f64.store
    i32.const 904 f64.const 618.13 f64.store
    i32.const 912 f64.const 619.14 f64.store
    i32.const 920 f64.const 620.15 f64.store
    i32.const 928 f64.const 621.16 f64.store
    i32.const 936 f64.const 622.17 f64.store
    i32.const 944 f64.const 623.18 f64.store
    i32.const 952 f64.const 624.19 f64.store
    i32.const 960 f64.const 625.20 f64.store
    i32.const 968 f64.const 626.21 f64.store
    i32.const 976 f64.const 627.22 f64.store
    i32.const 984 f64.const 628.23 f64.store
    i32.const 992 f64.const 629.24 f64.store
    i32.const 1000 f64.const 630.25 f64.store
    i32.const 1008 f64.const 631.26 f64.store
    i32.const 1016 f64.const 632.27 f64.store
    i32.const 1024 f64.const 633.28 f64.store
    i32.const 1032 f64.const 634.29 f64.store
    i32.const 1040 f64.const 635.30 f64.store
    i32.const 1048 f64.const 636.31 f64.store
    i32.const 1056 f64.const 637.32 f64.store
    i32.const 1064 f64.const 638.33 f64.store
    i32.const 1072 f64.const 639.34 f64.store
    i32.const 1080 f64.const 640.35 f64.store
    i32.const 1088 f64.const 641.36 f64.store
    i32.const 1096 f64.const 642.37 f64.store
    i32.const 1104 f64.const 643.38 f64.store
    i32.const 1112 f64.const 644.39 f64.store
    i32.const 1120 f64.const 645.40 f64.store
    i32.const 1128 f64.const 646.41 f64.store
    i32.const 1136 f64.const 647.42 f64.store
    i32.const 1144 f64.const 648.43 f64.store
    i32.const 1152 f64.const 649.44 f64.store
    i32.const 1160 f64.const 650.45 f64.store
    i32.const 1168 f64.const 651.46 f64.store
    i32.const 1176 f64.const 652.47 f64.store
    i32.const 1184 f64.const 653.48 f64.store
    i32.const 1192 f64.const 654.49 f64.store
    i32.const 1200 f64.const 655.50 f64.store
    i32.const 1208 f64.const 656.51 f64.store
    i32.const 1216 f64.const 657.52 f64.store
    i32.const 1224 f64.const 658.53 f64.store
    i32.const 1232 f64.const 659.54 f64.store
    i32.const 1240 f64.const 660.55 f64.store
    i32.const 1248 f64.const 661.56 f64.store
    i32.const 1256 f64.const 662.57 f64.store
    i32.const 1264 f64.const 663.58 f64.store
    i32.const 1272 f64.const 664.59 f64.store
    i32.const 1280 f64.const 665.60 f64.store
    i32.const 1288 f64.const 666.61 f64.store
    i32.const 1296 f64.const 667.62 f64.store
    i32.const 1304 f64.const 668.63 f64.store
    i32.const 1312 f64.const 669.64 f64.store
    i32.const 1320 f64.const 670.65 f64.store
    i32.const 1328 f64.const 671.66 f64.store
    i32.const 1336 f64.const 672.67 f64.store
    i32.const 1344 f64.const 673.68 f64.store
    i32.const 1352 f64.const 674.69 f64.store
    i32.const 1360 f64.const 675.70 f64.store
    i32.const 1368 f64.const 676.71 f64.store
    i32.const 1376 f64.const 677.72 f64.store
    i32.const 1384 f64.const 678.73 f64.store
    i32.const 1392 f64.const 679.74 f64.store
    i32.const 1400 f64.const 680.75 f64.store
    i32.const 1408 f64.const 681.76 f64.store
    i32.const 1416 f64.const 682.77 f64.store
    i32.const 1424 f64.const 683.78 f64.store
    i32.const 1432 f64.const 684.79 f64.store
    i32.const 1440 f64.const 685.80 f64.store
    i32.const 1448 f64.const 686.81 f64.store
    i32.const 1456 f64.const 687.82 f64.store
    i32.const 1464 f64.const 688.83 f64.store
    i32.const 1472 f64.const 689.84 f64.store
    i32.const 1480 f64.const 690.85 f64.store
    i32.const 1488 f64.const 691.86 f64.store
    i32.const 1496 f64.const 692.87 f64.store
    i32.const 1504 f64.const 693.88 f64.store
    i32.const 1512 f64.const 694.89 f64.store
    i32.const 1520 f64.const 695.90 f64.store
    i32.const 1528 f64.const 696.91 f64.store
    i32.const 1536 f64.const 697.92 f64.store
    i32.const 1544 f64.const 698.93 f64.store
    i32.const 1552 f64.const 699.94 f64.store
    i32.const 1560 f64.const 700.95 f64.store
    i32.const 1568 f64.const 701.96 f64.store
    i32.const 1576 f64.const 702.97 f64.store
    i32.const 1584 f64.const 703.98 f64.store
    i32.const 1592 f64.const 704.99 f64.store
  )
  (func $app_f (export "app_f")
    i32.const 0 f64.load drop
    i32.const 8 f64.load drop
    i32.const 16 f64.load drop
    i32.const 24 f64.load drop
    i32.const 32 f64.load drop
    i32.const 40 f64.load drop
    i32.const 48 f64.load drop
    i32.const 56 f64.load drop
    i32.const 64 f64.load drop
    i32.const 72 f64.load drop
    i32.const 80 f64.load drop
    i32.const 88 f64.load drop
    i32.const 96 f64.load drop
    i32.const 104 f64.load drop
    i32.const 112 f64.load drop
    i32.const 120 f64.load drop
    i32.const 128 f64.load drop
    i32.const 136 f64.load drop
    i32.const 144 f64.load drop
    i32.const 152 f64.load drop
    i32.const 160 f64.load drop
    i32.const 168 f64.load drop
    i32.const 176 f64.load drop
    i32.const 184 f64.load drop
    i32.const 192 f64.load drop
    i32.const 200 f64.load drop
    i32.const 208 f64.load drop
    i32.const 216 f64.load drop
    i32.const 224 f64.load drop
    i32.const 232 f64.load drop
    i32.const 240 f64.load drop
    i32.const 248 f64.load drop
    i32.const 256 f64.load drop
    i32.const 264 f64.load drop
    i32.const 272 f64.load drop
    i32.const 280 f64.load drop
    i32.const 288 f64.load drop
    i32.const 296 f64.load drop
    i32.const 304 f64.load drop
    i32.const 312 f64.load drop
    i32.const 320 f64.load drop
    i32.const 328 f64.load drop
    i32.const 336 f64.load drop
    i32.const 344 f64.load drop
    i32.const 352 f64.load drop
    i32.const 360 f64.load drop
    i32.const 368 f64.load drop
    i32.const 376 f64.load drop
    i32.const 384 f64.load drop
    i32.const 392 f64.load drop
    i32.const 400 f64.load drop
    i32.const 408 f64.load drop
    i32.const 416 f64.load drop
    i32.const 424 f64.load drop
    i32.const 432 f64.load drop
    i32.const 440 f64.load drop
    i32.const 448 f64.load drop
    i32.const 456 f64.load drop
    i32.const 464 f64.load drop
    i32.const 472 f64.load drop
    i32.const 480 f64.load drop
    i32.const 488 f64.load drop
    i32.const 496 f64.load drop
    i32.const 504 f64.load drop
    i32.const 512 f64.load drop
    i32.const 520 f64.load drop
    i32.const 528 f64.load drop
    i32.const 536 f64.load drop
    i32.const 544 f64.load drop
    i32.const 552 f64.load drop
    i32.const 560 f64.load drop
    i32.const 568 f64.load drop
    i32.const 576 f64.load drop
    i32.const 584 f64.load drop
    i32.const 592 f64.load drop
    i32.const 600 f64.load drop
    i32.const 608 f64.load drop
    i32.const 616 f64.load drop
    i32.const 624 f64.load drop
    i32.const 632 f64.load drop
    i32.const 640 f64.load drop
    i32.const 648 f64.load drop
    i32.const 656 f64.load drop
    i32.const 664 f64.load drop
    i32.const 672 f64.load drop
    i32.const 680 f64.load drop
    i32.const 688 f64.load drop
    i32.const 696 f64.load drop
    i32.const 704 f64.load drop
    i32.const 712 f64.load drop
    i32.const 720 f64.load drop
    i32.const 728 f64.load drop
    i32.const 736 f64.load drop
    i32.const 744 f64.load drop
    i32.const 752 f64.load drop
    i32.const 760 f64.load drop
    i32.const 768 f64.load drop
    i32.const 776 f64.load drop
    i32.const 784 f64.load drop
    i32.const 792 f64.load drop
    i32.const 800 f64.load drop
    i32.const 808 f64.load drop
    i32.const 816 f64.load drop
    i32.const 824 f64.load drop
    i32.const 832 f64.load drop
    i32.const 840 f64.load drop
    i32.const 848 f64.load drop
    i32.const 856 f64.load drop
    i32.const 864 f64.load drop
    i32.const 872 f64.load drop
    i32.const 880 f64.load drop
    i32.const 888 f64.load drop
    i32.const 896 f64.load drop
    i32.const 904 f64.load drop
    i32.const 912 f64.load drop
    i32.const 920 f64.load drop
    i32.const 928 f64.load drop
    i32.const 936 f64.load drop
    i32.const 944 f64.load drop
    i32.const 952 f64.load drop
    i32.const 960 f64.load drop
    i32.const 968 f64.load drop
    i32.const 976 f64.load drop
    i32.const 984 f64.load drop
    i32.const 992 f64.load drop
    i32.const 1000 f64.load drop
    i32.const 1008 f64.load drop
    i32.const 1016 f64.load drop
    i32.const 1024 f64.load drop
    i32.const 1032 f64.load drop
    i32.const 1040 f64.load drop
    i32.const 1048 f64.load drop
    i32.const 1056 f64.load drop
    i32.const 1064 f64.load drop
    i32.const 1072 f64.load drop
    i32.const 1080 f64.load drop
    i32.const 1088 f64.load drop
    i32.const 1096 f64.load drop
    i32.const 1104 f64.load drop
    i32.const 1112 f64.load drop
    i32.const 1120 f64.load drop
    i32.const 1128 f64.load drop
    i32.const 1136 f64.load drop
    i32.const 1144 f64.load drop
    i32.const 1152 f64.load drop
    i32.const 1160 f64.load drop
    i32.const 1168 f64.load drop
    i32.const 1176 f64.load drop
    i32.const 1184 f64.load drop
    i32.const 1192 f64.load drop
    i32.const 1200 f64.load drop
    i32.const 1208 f64.load drop
    i32.const 1216 f64.load drop
    i32.const 1224 f64.load drop
    i32.const 1232 f64.load drop
    i32.const 1240 f64.load drop
    i32.const 1248 f64.load drop
    i32.const 1256 f64.load drop
    i32.const 1264 f64.load drop
    i32.const 1272 f64.load drop
    i32.const 1280 f64.load drop
    i32.const 1288 f64.load drop
    i32.const 1296 f64.load drop
    i32.const 1304 f64.load drop
    i32.const 1312 f64.load drop
    i32.const 1320 f64.load drop
    i32.const 1328 f64.load drop
    i32.const 1336 f64.load drop
    i32.const 1344 f64.load drop
    i32.const 1352 f64.load drop
    i32.const 1360 f64.load drop
    i32.const 1368 f64.load drop
    i32.const 1376 f64.load drop
    i32.const 1384 f64.load drop
    i32.const 1392 f64.load drop
    i32.const 1400 f64.load drop
    i32.const 1408 f64.load drop
    i32.const 1416 f64.load drop
    i32.const 1424 f64.load drop
    i32.const 1432 f64.load drop
    i32.const 1440 f64.load drop
    i32.const 1448 f64.load drop
    i32.const 1456 f64.load drop
    i32.const 1464 f64.load drop
    i32.const 1472 f64.load drop
    i32.const 1480 f64.load drop
    i32.const 1488 f64.load drop
    i32.const 1496 f64.load drop
    i32.const 1504 f64.load drop
    i32.const 1512 f64.load drop
    i32.const 1520 f64.load drop
    i32.const 1528 f64.load drop
    i32.const 1536 f64.load drop
    i32.const 1544 f64.load drop
    i32.const 1552 f64.load drop
    i32.const 1560 f64.load drop
    i32.const 1568 f64.load drop
    i32.const 1576 f64.load drop
    i32.const 1584 f64.load drop
    i32.const 1592 f64.load drop
  )
)