(module
  (memory (export "memory") 1)
  (memory 1)
  (memory 1)
  (data (i32.const 0) "\21\22")
  (data (i32.const 8) "\22\23")
  (data (i32.const 16) "\23\24")
  (data (i32.const 24) "\24\25")
  (data (i32.const 32) "\25\26")
  (data (i32.const 40) "\26\27")
  (data (i32.const 48) "\27\28")
  (data (i32.const 56) "\28\29")
  (data (i32.const 64) "\29\2a")
  (data (i32.const 72) "\2a\2b")
  (data (i32.const 80) "\2b\2c")
  (data (i32.const 88) "\2c\2d")
  (data (i32.const 96) "\2d\2e")
  (data (i32.const 104) "\2e\2f")
  (data (i32.const 112) "\2f\30")
  (data (i32.const 120) "\30\31")
  (data (i32.const 128) "\31\32")
  (data (i32.const 136) "\32\33")
  (data (i32.const 144) "\33\34")
  (data (i32.const 152) "\34\35")
  (global $g0 (export "g0") (mut i64) (i64.const 0))
  (global $g1 (export "g1") (mut i64) (i64.const 1))
  (global $g2 (export "g2") (mut i64) (i64.const 2))
  (global $g3 (export "g3") (mut i64) (i64.const 3))
  (global $g4 (export "g4") (mut i64) (i64.const 4))
  (global $g5 (export "g5") (mut i64) (i64.const 5))
  (global $g6 (export "g6") (mut i64) (i64.const 6))
  (global $g7 (export "g7") (mut i64) (i64.const 7))
  (global $g8 (export "g8") (mut i64) (i64.const 8))
  (global $g9 (export "g9") (mut i64) (i64.const 9))
  (global $g10 (export "g10") (mut i64) (i64.const 10))
  (global $g11 (export "g11") (mut i64) (i64.const 11))
  (global $g12 (export "g12") (mut i64) (i64.const 12))
  (global $g13 (export "g13") (mut i64) (i64.const 13))
  (global $g14 (export "g14") (mut i64) (i64.const 14))
  (global $g15 (export "g15") (mut i64) (i64.const 15))
  (global $g16 (export "g16") (mut i64) (i64.const 16))
  (global $g17 (export "g17") (mut i64) (i64.const 17))
  (global $g18 (export "g18") (mut i64) (i64.const 18))
  (global $g19 (export "g19") (mut i64) (i64.const 19))
  (global $g20 (export "g20") (mut i64) (i64.const 20))
  (global $g21 (export "g21") (mut i64) (i64.const 21))
  (global $g22 (export "g22") (mut i64) (i64.const 22))
  (global $g23 (export "g23") (mut i64) (i64.const 23))
  (global $g24 (export "g24") (mut i64) (i64.const 24))
  (global $g25 (export "g25") (mut i64) (i64.const 25))
  (global $g26 (export "g26") (mut i64) (i64.const 26))
  (global $g27 (export "g27") (mut i64) (i64.const 27))
  (global $g28 (export "g28") (mut i64) (i64.const 28))
  (global $g29 (export "g29") (mut i64) (i64.const 29))
  (global $g30 (export "g30") (mut i64) (i64.const 30))
  (global $g31 (export "g31") (mut i64) (i64.const 31))
  (global $g32 (export "g32") (mut i64) (i64.const 32))
  (global $g33 (export "g33") (mut i64) (i64.const 33))
  (global $g34 (export "g34") (mut i64) (i64.const 34))
  (global $g35 (export "g35") (mut i64) (i64.const 35))
  (global $g36 (export "g36") (mut i64) (i64.const 36))
  (global $g37 (export "g37") (mut i64) (i64.const 37))
  (global $g38 (export "g38") (mut i64) (i64.const 38))
  (global $g39 (export "g39") (mut i64) (i64.const 39))
  (global $g40 (export "g40") (mut i64) (i64.const 40))
  (global $g41 (export "g41") (mut i64) (i64.const 41))
  (global $g42 (export "g42") (mut i64) (i64.const 42))
  (global $g43 (export "g43") (mut i64) (i64.const 43))
  (global $g44 (export "g44") (mut i64) (i64.const 44))
  (global $g45 (export "g45") (mut i64) (i64.const 45))
  (global $g46 (export "g46") (mut i64) (i64.const 46))
  (global $g47 (export "g47") (mut i64) (i64.const 47))
  (global $g48 (export "g48") (mut i64) (i64.const 48))
  (global $g49 (export "g49") (mut i64) (i64.const 49))
  (global $g50 (export "g50") (mut i64) (i64.const 50))
  (global $g51 (export "g51") (mut i64) (i64.const 51))
  (global $g52 (export "g52") (mut i64) (i64.const 52))
  (global $g53 (export "g53") (mut i64) (i64.const 53))
  (global $g54 (export "g54") (mut i64) (i64.const 54))
  (global $g55 (export "g55") (mut i64) (i64.const 55))
  (global $g56 (export "g56") (mut i64) (i64.const 56))
  (global $g57 (export "g57") (mut i64) (i64.const 57))
  (global $g58 (export "g58") (mut i64) (i64.const 58))
  (global $g59 (export "g59") (mut i64) (i64.const 59))
  (func $r3_main (export "_start") (export "main")
    call $r3_setup
    call $app_0
    call $app_1
    call $app_2
    call $app_3
    call $app_4
    call $app_5
    call $app_6
    call $app_7
    call $app_8
    call $app_9
    call $app_10
    call $app_11
    call $app_12
    call $app_13
    call $app_14
    call $app_15
    call $app_16
    call $app_17
    call $app_18
    call $app_19
    call $app_20
    call $app_21
    call $app_22
    call $app_23
    call $app_24
    call $app_25
    call $app_26
    call $app_27
    call $app_28
    call $app_29
    call $app_30
    call $app_31
    call $app_32
    call $app_33
    call $app_34
    call $app_35
    call $app_36
    call $app_37
    call $app_38
    call $app_39
    call $app_40
    call $app_41
    call $app_42
    call $app_43
    call $app_44
    call $app_45
    call $app_46
    call $app_47
    call $app_48
    call $app_49
    call $app_50
    call $app_51
    call $app_52
    call $app_53
    call $app_54
    call $app_55
    call $app_56
    call $app_57
    call $app_58
    call $app_59
    call $app_60
    call $app_61
    call $app_62
    call $app_63
    call $app_64
    call $app_65
    call $app_66
    call $app_67
    call $app_68
    call $app_69
    call $app_70
    call $app_71
    call $app_72
    call $app_73
    call $app_74
    call $app_75
    call $app_76
    call $app_77
    call $app_78
    call $app_79
    call $app_80
    call $app_81
    call $app_82
    call $app_83
    call $app_84
    call $app_85
    call $app_86
    call $app_87
    call $app_88
    call $app_89
    call $app_90
    call $app_91
    call $app_92
    call $app_93
    call $app_94
    call $app_95
    call $app_96
    call $app_97
    call $app_98
    call $app_99
    call $app_100
    call $app_101
    call $app_102
    call $app_103
    call $app_104
    call $app_105
    call $app_106
    call $app_107
    call $app_108
    call $app_109
    call $app_110
    call $app_111
    call $app_112
    call $app_113
    call $app_114
    call $app_115
    call $app_116
    call $app_117
    call $app_118
    call $app_119
    call $app_globals
  )
  (func $r3_setup
    i32.const 100 i32.const 9505 i32.store 0
    i32.const 108 i32.const 9506 i32.store 1
    i32.const 116 i32.const 9507 i32.store 2
    i64.const 9505 global.set 0
    i64.const 9512 global.set 1
    i64.const 9519 global.set 2
    i64.const 9526 global.set 3
    i64.const 9533 global.set 4
    i64.const 9540 global.set 5
    i64.const 9547 global.set 6
    i64.const 9554 global.set 7
    i64.const 9561 global.set 8
    i64.const 9568 global.set 9
    i64.const 9575 global.set 10
    i64.const 9582 global.set 11
    i64.const 9589 global.set 12
    i64.const 9596 global.set 13
    i64.const 9603 global.set 14
    i64.const 9610 global.set 15
    i64.const 9617 global.set 16
    i64.const 9624 global.set 17
    i64.const 9631 global.set 18
    i64.const 9638 global.set 19
    i64.const 9645 global.set 20
    i64.const 9652 global.set 21
    i64.const 9659 global.set 22
    i64.const 9666 global.set 23
    i64.const 9673 global.set 24
    i64.const 9680 global.set 25
    i64.const 9687 global.set 26
    i64.const 9694 global.set 27
    i64.const 9701 global.set 28
    i64.const 9708 global.set 29
    i64.const 9715 global.set 30
    i64.const 9722 global.set 31
    i64.const 9729 global.set 32
    i64.const 9736 global.set 33
    i64.const 9743 global.set 34
    i64.const 9750 global.set 35
    i64.const 9757 global.set 36
    i64.const 9764 global.set 37
    i64.const 9771 global.set 38
    i64.const 9778 global.set 39
    i64.const 9785 global.set 40
    i64.const 9792 global.set 41
    i64.const 9799 global.set 42
    i64.const 9806 global.set 43
    i64.const 9813 global.set 44
    i64.const 9820 global.set 45
    i64.const 9827 global.set 46
    i64.const 9834 global.set 47
    i64.const 9841 global.set 48
    i64.const 9848 global.set 49
    i64.const 9855 global.set 50
    i64.const 9862 global.set 51
    i64.const 9869 global.set 52
    i64.const 9876 global.set 53
    i64.const 9883 global.set 54
    i64.const 9890 global.set 55
    i64.const 9897 global.set 56
    i64.const 9904 global.set 57
    i64.const 9911 global.set 58
    i64.const 9918 global.set 59
  )
  (func $app_0 (export "app_0") i32.const 100 i32.load 0 drop)
  (func $app_1 (export "app_1") i32.const 108 i32.load 1 drop)
  (func $app_2 (export "app_2") i32.const 116 i32.load 2 drop)
  (func $app_3 (export "app_3") i32.const 100 i32.load 0 drop)
  (func $app_4 (export "app_4") i32.const 108 i32.load 1 drop)
  (func $app_5 (export "app_5") i32.const 116 i32.load 2 drop)
  (func $app_6 (export "app_6") i32.const 100 i32.load 0 drop)
  (func $app_7 (export "app_7") i32.const 108 i32.load 1 drop)
  (func $app_8 (export "app_8") i32.const 116 i32.load 2 drop)
  (func $app_9 (export "app_9") i32.const 100 i32.load 0 drop)
  (func $app_10 (export "app_10") i32.const 108 i32.load 1 drop)
  (func $app_11 (export "app_11") i32.const 116 i32.load 2 drop)
  (func $app_12 (export "app_12") i32.const 100 i32.load 0 drop)
  (func $app_13 (export "app_13") i32.const 108 i32.load 1 drop)
  (func $app_14 (export "app_14") i32.const 116 i32.load 2 drop)
  (func $app_15 (export "app_15") i32.const 100 i32.load 0 drop)
  (func $app_16 (export "app_16") i32.const 108 i32.load 1 drop)
  (func $app_17 (export "app_17") i32.const 116 i32.load 2 drop)
  (func $app_18 (export "app_18") i32.const 100 i32.load 0 drop)
  (func $app_19 (export "app_19") i32.const 108 i32.load 1 drop)
  (func $app_20 (export "app_20") i32.const 116 i32.load 2 drop)
  (func $app_21 (export "app_21") i32.const 100 i32.load 0 drop)
  (func $app_22 (export "app_22") i32.const 108 i32.load 1 drop)
  (func $app_23 (export "app_23") i32.const 116 i32.load 2 drop)
  (func $app_24 (export "app_24") i32.const 100 i32.load 0 drop)
  (func $app_25 (export "app_25") i32.const 108 i32.load 1 drop)
  (func $app_26 (export "app_26") i32.const 116 i32.load 2 drop)
  (func $app_27 (export "app_27") i32.const 100 i32.load 0 drop)
  (func $app_28 (export "app_28") i32.const 108 i32.load 1 drop)
  (func $app_29 (export "app_29") i32.const 116 i32.load 2 drop)
  (func $app_30 (export "app_30") i32.const 100 i32.load 0 drop)
  (func $app_31 (export "app_31") i32.const 108 i32.load 1 drop)
  (func $app_32 (export "app_32") i32.const 116 i32.load 2 drop)
  (func $app_33 (export "app_33") i32.const 100 i32.load 0 drop)
  (func $app_34 (export "app_34") i32.const 108 i32.load 1 drop)
  (func $app_35 (export "app_35") i32.const 116 i32.load 2 drop)
  (func $app_36 (export "app_36") i32.const 100 i32.load 0 drop)
  (func $app_37 (export "app_37") i32.const 108 i32.load 1 drop)
  (func $app_38 (export "app_38") i32.const 116 i32.load 2 drop)
  (func $app_39 (export "app_39") i32.const 100 i32.load 0 drop)
  (func $app_40 (export "app_40") i32.const 108 i32.load 1 drop)
  (func $app_41 (export "app_41") i32.const 116 i32.load 2 drop)
  (func $app_42 (export "app_42") i32.const 100 i32.load 0 drop)
  (func $app_43 (export "app_43") i32.const 108 i32.load 1 drop)
  (func $app_44 (export "app_44") i32.const 116 i32.load 2 drop)
  (func $app_45 (export "app_45") i32.const 100 i32.load 0 drop)
  (func $app_46 (export "app_46") i32.const 108 i32.load 1 drop)
  (func $app_47 (export "app_47") i32.const 116 i32.load 2 drop)
  (func $app_48 (export "app_48") i32.const 100 i32.load 0 drop)
  (func $app_49 (export "app_49") i32.const 108 i32.load 1 drop)
  (func $app_50 (export "app_50") i32.const 116 i32.load 2 drop)
  (func $app_51 (export "app_51") i32.const 100 i32.load 0 drop)
  (func $app_52 (export "app_52") i32.const 108 i32.load 1 drop)
  (func $app_53 (export "app_53") i32.const 116 i32.load 2 drop)
  (func $app_54 (export "app_54") i32.const 100 i32.load 0 drop)
  (func $app_55 (export "app_55") i32.const 108 i32.load 1 drop)
  (func $app_56 (export "app_56") i32.const 116 i32.load 2 drop)
  (func $app_57 (export "app_57") i32.const 100 i32.load 0 drop)
  (func $app_58 (export "app_58") i32.const 108 i32.load 1 drop)
  (func $app_59 (export "app_59") i32.const 116 i32.load 2 drop)
  (func $app_60 (export "app_60") i32.const 100 i32.load 0 drop)
  (func $app_61 (export "app_61") i32.const 108 i32.load 1 drop)
  (func $app_62 (export "app_62") i32.const 116 i32.load 2 drop)
  (func $app_63 (export "app_63") i32.const 100 i32.load 0 drop)
  (func $app_64 (export "app_64") i32.const 108 i32.load 1 drop)
  (func $app_65 (export "app_65") i32.const 116 i32.load 2 drop)
  (func $app_66 (export "app_66") i32.const 100 i32.load 0 drop)
  (func $app_67 (export "app_67") i32.const 108 i32.load 1 drop)
  (func $app_68 (export "app_68") i32.const 116 i32.load 2 drop)
  (func $app_69 (export "app_69") i32.const 100 i32.load 0 drop)
  (func $app_70 (export "app_70") i32.const 108 i32.load 1 drop)
  (func $app_71 (export "app_71") i32.const 116 i32.load 2 drop)
  (func $app_72 (export "app_72") i32.const 100 i32.load 0 drop)
  (func $app_73 (export "app_73") i32.const 108 i32.load 1 drop)
  (func $app_74 (export "app_74") i32.const 116 i32.load 2 drop)
  (func $app_75 (export "app_75") i32.const 100 i32.load 0 drop)
  (func $app_76 (export "app_76") i32.const 108 i32.load 1 drop)
  (func $app_77 (export "app_77") i32.const 116 i32.load 2 drop)
  (func $app_78 (export "app_78") i32.const 100 i32.load 0 drop)
  (func $app_79 (export "app_79") i32.const 108 i32.load 1 drop)
  (func $app_80 (export "app_80") i32.const 116 i32.load 2 drop)
  (func $app_81 (export "app_81") i32.const 100 i32.load 0 drop)
  (func $app_82 (export "app_82") i32.const 108 i32.load 1 drop)
  (func $app_83 (export "app_83") i32.const 116 i32.load 2 drop)
  (func $app_84 (export "app_84") i32.const 100 i32.load 0 drop)
  (func $app_85 (export "app_85") i32.const 108 i32.load 1 drop)
  (func $app_86 (export "app_86") i32.const 116 i32.load 2 drop)
  (func $app_87 (export "app_87") i32.const 100 i32.load 0 drop)
  (func $app_88 (export "app_88") i32.const 108 i32.load 1 drop)
  (func $app_89 (export "app_89") i32.const 116 i32.load 2 drop)
  (func $app_90 (export "app_90") i32.const 100 i32.load 0 drop)
  (func $app_91 (export "app_91") i32.const 108 i32.load 1 drop)
  (func $app_92 (export "app_92") i32.const 116 i32.load 2 drop)
  (func $app_93 (export "app_93") i32.const 100 i32.load 0 drop)
  (func $app_94 (export "app_94") i32.const 108 i32.load 1 drop)
  (func $app_95 (export "app_95") i32.const 116 i32.load 2 drop)
  (func $app_96 (export "app_96") i32.const 100 i32.load 0 drop)
  (func $app_97 (export "app_97") i32.const 108 i32.load 1 drop)
  (func $app_98 (export "app_98") i32.const 116 i32.load 2 drop)
  (func $app_99 (export "app_99") i32.const 100 i32.load 0 drop)
  (func $app_100 (export "app_100") i32.const 108 i32.load 1 drop)
  (func $app_101 (export "app_101") i32.const 116 i32.load 2 drop)
  (func $app_102 (export "app_102") i32.const 100 i32.load 0 drop)
  (func $app_103 (export "app_103") i32.const 108 i32.load 1 drop)
  (func $app_104 (export "app_104") i32.const 116 i32.load 2 drop)
  (func $app_105 (export "app_105") i32.const 100 i32.load 0 drop)
  (func $app_106 (export "app_106") i32.const 108 i32.load 1 drop)
  (func $app_107 (export "app_107") i32.const 116 i32.load 2 drop)
  (func $app_108 (export "app_108") i32.const 100 i32.load 0 drop)
  (func $app_109 (export "app_109") i32.const 108 i32.load 1 drop)
  (func $app_110 (export "app_110") i32.const 116 i32.load 2 drop)
  (func $app_111 (export "app_111") i32.const 100 i32.load 0 drop)
  (func $app_112 (export "app_112") i32.const 108 i32.load 1 drop)
  (func $app_113 (export "app_113") i32.const 116 i32.load 2 drop)
  (func $app_114 (export "app_114") i32.const 100 i32.load 0 drop)
  (func $app_115 (export "app_115") i32.const 108 i32.load 1 drop)
  (func $app_116 (export "app_116") i32.const 116 i32.load 2 drop)
  (func $app_117 (export "app_117") i32.const 100 i32.load 0 drop)
  (func $app_118 (export "app_118") i32.const 108 i32.load 1 drop)
  (func $app_119 (export "app_119") i32.const 116 i32.load 2 drop)
  (func $app_globals (export "app_globals")
    global.get 0 drop
    global.get 1 drop
    global.get 2 drop
    global.get 3 drop
    global.get 4 drop
    global.get 5 drop
    global.get 6 drop
    global.get 7 drop
    global.get 8 drop
    global.get 9 drop
    global.get 10 drop
    global.get 11 drop
    global.get 12 drop
    global.get 13 drop
    global.get 14 drop
    global.get 15 drop
    global.get 16 drop
    global.get 17 drop
    global.get 18 drop
    global.get 19 drop
    global.get 20 drop
    global.get 21 drop
    global.get 22 drop
    global.get 23 drop
    global.get 24 drop
    global.get 25 drop
    global.get 26 drop
    global.get 27 drop
    global.get 28 drop
    global.get 29 drop
    global.get 30 drop
    global.get 31 drop
    global.get 32 drop
    global.get 33 drop
    global.get 34 drop
    global.get 35 drop
    global.get 36 drop
    global.get 37 drop
    global.get 38 drop
    global.get 39 drop
    global.get 40 drop
    global.get 41 drop
    global.get 42 drop
    global.get 43 drop
    global.get 44 drop
    global.get 45 drop
    global.get 46 drop
    global.get 47 drop
    global.get 48 drop
    global.get 49 drop
    global.get 50 drop
    global.get 51 drop
    global.get 52 drop
    global.get 53 drop
    global.get 54 drop
    global.get 55 drop
    global.get 56 drop
    global.get 57 drop
    global.get 58 drop
    global.get 59 drop
  )
)