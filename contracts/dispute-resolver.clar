;; Handles bounty disputes
(define-constant err-not-found u1)
(define-map Dispute
  uint
  { reason: (string-utf8 200), status: (string-ascii 10) })

;; Open dispute
(define-public (open-dispute (bounty-id uint) (reason (string-utf8 200)))
  (begin
    (map-set Dispute bounty-id { reason: reason, status: "open" })
    (ok true)))

;; Resolve dispute via oracle
(define-public (resolve-dispute (bounty-id uint) (resolution bool))
  (let ((dispute (unwrap! (map-get? Dispute bounty-id) (err err-not-found))))
    (asserts! (is-eq (get status dispute) "open") (err u2))
    (map-set Dispute bounty-id (merge dispute { status: "resolved" }))
    (ok resolution)))