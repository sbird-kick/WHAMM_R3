;; Host module for report_recurse_ig_reorder.wat: exports the two mutable
;; globals ($a index 0, $b index 1) the consumer module imports and reads,
;; one per recursion level, to test IG-vs-report-batch ordering.
(module
  (global (export "a") (mut i32) (i32.const 111))
  (global (export "b") (mut i32) (i32.const 222))
)
