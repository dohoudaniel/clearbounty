;; Handles bounty funds in escrow
(define-constant err-unauthorized u0)

(define-map Escrow
  uint
  { amount: uint, status: (string-ascii 10) })

;; Lock funds in escrow
(define-public (lock-funds (bounty-id uint) (amount uint))
  (begin
    (map-set Escrow bounty-id { amount: amount, status: "locked" })
    (ok true)))

;; Release funds to freelancer
(define-public (release-funds (bounty-id uint) (recipient principal))
  (let ((escrow (unwrap! (map-get? Escrow bounty-id) (err u1))))
    (asserts! (is-eq (get status escrow) "locked") (err u2))
    (map-set Escrow bounty-id (merge escrow { status: "released" }))
    (stx-transfer? (get amount escrow) tx-sender recipient)))