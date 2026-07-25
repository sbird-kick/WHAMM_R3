(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main") call $r3_poke call $app_f)
  (func $r3_poke
    i32.const 0 i32.const 9505 i32.store8
    i32.const 8 i32.const 9506 i32.store16
    i32.const 16 i32.const 9507 i32.store
    i32.const 24 i64.const 9508 i64.store8
    i32.const 32 i64.const 9509 i64.store32
    i32.const 40 i32.const 9510 i32.store8
    i32.const 48 i32.const 9511 i32.store16
    i32.const 56 i32.const 9512 i32.store
    i32.const 64 i64.const 9513 i64.store8
    i32.const 72 i64.const 9514 i64.store32
    i32.const 80 i32.const 9515 i32.store8
    i32.const 88 i32.const 9516 i32.store16
    i32.const 96 i32.const 9517 i32.store
    i32.const 104 i64.const 9518 i64.store8
    i32.const 112 i64.const 9519 i64.store32
    i32.const 120 i32.const 9520 i32.store8
    i32.const 128 i32.const 9521 i32.store16
    i32.const 136 i32.const 9522 i32.store
    i32.const 144 i64.const 9523 i64.store8
    i32.const 152 i64.const 9524 i64.store32
    i32.const 160 i32.const 9525 i32.store8
    i32.const 168 i32.const 9526 i32.store16
    i32.const 176 i32.const 9527 i32.store
    i32.const 184 i64.const 9528 i64.store8
    i32.const 192 i64.const 9529 i64.store32
    i32.const 200 i32.const 9530 i32.store8
    i32.const 208 i32.const 9531 i32.store16
    i32.const 216 i32.const 9532 i32.store
    i32.const 224 i64.const 9533 i64.store8
    i32.const 232 i64.const 9534 i64.store32
    i32.const 240 i32.const 9535 i32.store8
    i32.const 248 i32.const 9536 i32.store16
    i32.const 256 i32.const 9537 i32.store
    i32.const 264 i64.const 9538 i64.store8
    i32.const 272 i64.const 9539 i64.store32
    i32.const 280 i32.const 9540 i32.store8
    i32.const 288 i32.const 9541 i32.store16
    i32.const 296 i32.const 9542 i32.store
    i32.const 304 i64.const 9543 i64.store8
    i32.const 312 i64.const 9544 i64.store32
    i32.const 320 i32.const 9545 i32.store8
    i32.const 328 i32.const 9546 i32.store16
    i32.const 336 i32.const 9547 i32.store
    i32.const 344 i64.const 9548 i64.store8
    i32.const 352 i64.const 9549 i64.store32
    i32.const 360 i32.const 9550 i32.store8
    i32.const 368 i32.const 9551 i32.store16
    i32.const 376 i32.const 9552 i32.store
    i32.const 384 i64.const 9553 i64.store8
    i32.const 392 i64.const 9554 i64.store32
    i32.const 400 i32.const 9555 i32.store8
    i32.const 408 i32.const 9556 i32.store16
    i32.const 416 i32.const 9557 i32.store
    i32.const 424 i64.const 9558 i64.store8
    i32.const 432 i64.const 9559 i64.store32
    i32.const 440 i32.const 9560 i32.store8
    i32.const 448 i32.const 9561 i32.store16
    i32.const 456 i32.const 9562 i32.store
    i32.const 464 i64.const 9563 i64.store8
    i32.const 472 i64.const 9564 i64.store32
    i32.const 480 i32.const 9565 i32.store8
    i32.const 488 i32.const 9566 i32.store16
    i32.const 496 i32.const 9567 i32.store
    i32.const 504 i64.const 9568 i64.store8
    i32.const 512 i64.const 9569 i64.store32
    i32.const 520 i32.const 9570 i32.store8
    i32.const 528 i32.const 9571 i32.store16
    i32.const 536 i32.const 9572 i32.store
    i32.const 544 i64.const 9573 i64.store8
    i32.const 552 i64.const 9574 i64.store32
    i32.const 560 i32.const 9575 i32.store8
    i32.const 568 i32.const 9576 i32.store16
    i32.const 576 i32.const 9577 i32.store
    i32.const 584 i64.const 9578 i64.store8
    i32.const 592 i64.const 9579 i64.store32
    i32.const 600 i32.const 9580 i32.store8
    i32.const 608 i32.const 9581 i32.store16
    i32.const 616 i32.const 9582 i32.store
    i32.const 624 i64.const 9583 i64.store8
    i32.const 632 i64.const 9584 i64.store32
    i32.const 640 i32.const 9585 i32.store8
    i32.const 648 i32.const 9586 i32.store16
    i32.const 656 i32.const 9587 i32.store
    i32.const 664 i64.const 9588 i64.store8
    i32.const 672 i64.const 9589 i64.store32
    i32.const 680 i32.const 9590 i32.store8
    i32.const 688 i32.const 9591 i32.store16
    i32.const 696 i32.const 9592 i32.store
    i32.const 704 i64.const 9593 i64.store8
    i32.const 712 i64.const 9594 i64.store32
    i32.const 720 i32.const 9595 i32.store8
    i32.const 728 i32.const 9596 i32.store16
    i32.const 736 i32.const 9597 i32.store
    i32.const 744 i64.const 9598 i64.store8
    i32.const 752 i64.const 9599 i64.store32
    i32.const 760 i32.const 9600 i32.store8
    i32.const 768 i32.const 9601 i32.store16
    i32.const 776 i32.const 9602 i32.store
    i32.const 784 i64.const 9603 i64.store8
    i32.const 792 i64.const 9604 i64.store32
    i32.const 800 i32.const 9605 i32.store8
    i32.const 808 i32.const 9606 i32.store16
    i32.const 816 i32.const 9607 i32.store
    i32.const 824 i64.const 9608 i64.store8
    i32.const 832 i64.const 9609 i64.store32
    i32.const 840 i32.const 9610 i32.store8
    i32.const 848 i32.const 9611 i32.store16
    i32.const 856 i32.const 9612 i32.store
    i32.const 864 i64.const 9613 i64.store8
    i32.const 872 i64.const 9614 i64.store32
    i32.const 880 i32.const 9615 i32.store8
    i32.const 888 i32.const 9616 i32.store16
    i32.const 896 i32.const 9617 i32.store
    i32.const 904 i64.const 9618 i64.store8
    i32.const 912 i64.const 9619 i64.store32
    i32.const 920 i32.const 9620 i32.store8
    i32.const 928 i32.const 9621 i32.store16
    i32.const 936 i32.const 9622 i32.store
    i32.const 944 i64.const 9623 i64.store8
    i32.const 952 i64.const 9624 i64.store32
    i32.const 960 i32.const 9625 i32.store8
    i32.const 968 i32.const 9626 i32.store16
    i32.const 976 i32.const 9627 i32.store
    i32.const 984 i64.const 9628 i64.store8
    i32.const 992 i64.const 9629 i64.store32
    i32.const 1000 i32.const 9630 i32.store8
    i32.const 1008 i32.const 9631 i32.store16
    i32.const 1016 i32.const 9632 i32.store
    i32.const 1024 i64.const 9633 i64.store8
    i32.const 1032 i64.const 9634 i64.store32
    i32.const 1040 i32.const 9635 i32.store8
    i32.const 1048 i32.const 9636 i32.store16
    i32.const 1056 i32.const 9637 i32.store
    i32.const 1064 i64.const 9638 i64.store8
    i32.const 1072 i64.const 9639 i64.store32
    i32.const 1080 i32.const 9640 i32.store8
    i32.const 1088 i32.const 9641 i32.store16
    i32.const 1096 i32.const 9642 i32.store
    i32.const 1104 i64.const 9643 i64.store8
    i32.const 1112 i64.const 9644 i64.store32
    i32.const 1120 i32.const 9645 i32.store8
    i32.const 1128 i32.const 9646 i32.store16
    i32.const 1136 i32.const 9647 i32.store
    i32.const 1144 i64.const 9648 i64.store8
    i32.const 1152 i64.const 9649 i64.store32
    i32.const 1160 i32.const 9650 i32.store8
    i32.const 1168 i32.const 9651 i32.store16
    i32.const 1176 i32.const 9652 i32.store
    i32.const 1184 i64.const 9653 i64.store8
    i32.const 1192 i64.const 9654 i64.store32
  )
  (func $app_f (export "app_f")
    i32.const 0 i32.load8_u drop
    i32.const 8 i32.load16_u drop
    i32.const 16 i32.load drop
    i32.const 24 i64.load8_u drop
    i32.const 32 i64.load32_u drop
    i32.const 40 i32.load8_u drop
    i32.const 48 i32.load16_u drop
    i32.const 56 i32.load drop
    i32.const 64 i64.load8_u drop
    i32.const 72 i64.load32_u drop
    i32.const 80 i32.load8_u drop
    i32.const 88 i32.load16_u drop
    i32.const 96 i32.load drop
    i32.const 104 i64.load8_u drop
    i32.const 112 i64.load32_u drop
    i32.const 120 i32.load8_u drop
    i32.const 128 i32.load16_u drop
    i32.const 136 i32.load drop
    i32.const 144 i64.load8_u drop
    i32.const 152 i64.load32_u drop
    i32.const 160 i32.load8_u drop
    i32.const 168 i32.load16_u drop
    i32.const 176 i32.load drop
    i32.const 184 i64.load8_u drop
    i32.const 192 i64.load32_u drop
    i32.const 200 i32.load8_u drop
    i32.const 208 i32.load16_u drop
    i32.const 216 i32.load drop
    i32.const 224 i64.load8_u drop
    i32.const 232 i64.load32_u drop
    i32.const 240 i32.load8_u drop
    i32.const 248 i32.load16_u drop
    i32.const 256 i32.load drop
    i32.const 264 i64.load8_u drop
    i32.const 272 i64.load32_u drop
    i32.const 280 i32.load8_u drop
    i32.const 288 i32.load16_u drop
    i32.const 296 i32.load drop
    i32.const 304 i64.load8_u drop
    i32.const 312 i64.load32_u drop
    i32.const 320 i32.load8_u drop
    i32.const 328 i32.load16_u drop
    i32.const 336 i32.load drop
    i32.const 344 i64.load8_u drop
    i32.const 352 i64.load32_u drop
    i32.const 360 i32.load8_u drop
    i32.const 368 i32.load16_u drop
    i32.const 376 i32.load drop
    i32.const 384 i64.load8_u drop
    i32.const 392 i64.load32_u drop
    i32.const 400 i32.load8_u drop
    i32.const 408 i32.load16_u drop
    i32.const 416 i32.load drop
    i32.const 424 i64.load8_u drop
    i32.const 432 i64.load32_u drop
    i32.const 440 i32.load8_u drop
    i32.const 448 i32.load16_u drop
    i32.const 456 i32.load drop
    i32.const 464 i64.load8_u drop
    i32.const 472 i64.load32_u drop
    i32.const 480 i32.load8_u drop
    i32.const 488 i32.load16_u drop
    i32.const 496 i32.load drop
    i32.const 504 i64.load8_u drop
    i32.const 512 i64.load32_u drop
    i32.const 520 i32.load8_u drop
    i32.const 528 i32.load16_u drop
    i32.const 536 i32.load drop
    i32.const 544 i64.load8_u drop
    i32.const 552 i64.load32_u drop
    i32.const 560 i32.load8_u drop
    i32.const 568 i32.load16_u drop
    i32.const 576 i32.load drop
    i32.const 584 i64.load8_u drop
    i32.const 592 i64.load32_u drop
    i32.const 600 i32.load8_u drop
    i32.const 608 i32.load16_u drop
    i32.const 616 i32.load drop
    i32.const 624 i64.load8_u drop
    i32.const 632 i64.load32_u drop
    i32.const 640 i32.load8_u drop
    i32.const 648 i32.load16_u drop
    i32.const 656 i32.load drop
    i32.const 664 i64.load8_u drop
    i32.const 672 i64.load32_u drop
    i32.const 680 i32.load8_u drop
    i32.const 688 i32.load16_u drop
    i32.const 696 i32.load drop
    i32.const 704 i64.load8_u drop
    i32.const 712 i64.load32_u drop
    i32.const 720 i32.load8_u drop
    i32.const 728 i32.load16_u drop
    i32.const 736 i32.load drop
    i32.const 744 i64.load8_u drop
    i32.const 752 i64.load32_u drop
    i32.const 760 i32.load8_u drop
    i32.const 768 i32.load16_u drop
    i32.const 776 i32.load drop
    i32.const 784 i64.load8_u drop
    i32.const 792 i64.load32_u drop
    i32.const 800 i32.load8_u drop
    i32.const 808 i32.load16_u drop
    i32.const 816 i32.load drop
    i32.const 824 i64.load8_u drop
    i32.const 832 i64.load32_u drop
    i32.const 840 i32.load8_u drop
    i32.const 848 i32.load16_u drop
    i32.const 856 i32.load drop
    i32.const 864 i64.load8_u drop
    i32.const 872 i64.load32_u drop
    i32.const 880 i32.load8_u drop
    i32.const 888 i32.load16_u drop
    i32.const 896 i32.load drop
    i32.const 904 i64.load8_u drop
    i32.const 912 i64.load32_u drop
    i32.const 920 i32.load8_u drop
    i32.const 928 i32.load16_u drop
    i32.const 936 i32.load drop
    i32.const 944 i64.load8_u drop
    i32.const 952 i64.load32_u drop
    i32.const 960 i32.load8_u drop
    i32.const 968 i32.load16_u drop
    i32.const 976 i32.load drop
    i32.const 984 i64.load8_u drop
    i32.const 992 i64.load32_u drop
    i32.const 1000 i32.load8_u drop
    i32.const 1008 i32.load16_u drop
    i32.const 1016 i32.load drop
    i32.const 1024 i64.load8_u drop
    i32.const 1032 i64.load32_u drop
    i32.const 1040 i32.load8_u drop
    i32.const 1048 i32.load16_u drop
    i32.const 1056 i32.load drop
    i32.const 1064 i64.load8_u drop
    i32.const 1072 i64.load32_u drop
    i32.const 1080 i32.load8_u drop
    i32.const 1088 i32.load16_u drop
    i32.const 1096 i32.load drop
    i32.const 1104 i64.load8_u drop
    i32.const 1112 i64.load32_u drop
    i32.const 1120 i32.load8_u drop
    i32.const 1128 i32.load16_u drop
    i32.const 1136 i32.load drop
    i32.const 1144 i64.load8_u drop
    i32.const 1152 i64.load32_u drop
    i32.const 1160 i32.load8_u drop
    i32.const 1168 i32.load16_u drop
    i32.const 1176 i32.load drop
    i32.const 1184 i64.load8_u drop
    i32.const 1192 i64.load32_u drop
  )
)