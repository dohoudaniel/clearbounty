;; Bounty manager handles bounty lifecycle
(define-constant contract-owner tx-sender)
(define-data-var next-id uint u0)
(define-map Bounty
  uint
  { owner: principal, title: (string-utf8 100), reward: uint,
    deadline: uint, status: (string-ascii 10) })

;; Create new bounty
(define-public (create-bounty (title (string-utf8 100)) (reward uint) (deadline uint))
  (let ((id (var-get next-id)))
    (map-set Bounty id { owner: tx-sender, title: title, reward: reward,
                        deadline: deadline, status: "open" })
    (var-set next-id (+ id u1))
    (ok id)))

;; Cancel bounty
(define-public (cancel-bounty (id uint))
  (let ((bounty (unwrap! (map-get? Bounty id) (err u1))))
    (asserts! (is-eq tx-sender (get owner bounty)) (err u2))
    (asserts! (is-eq (get status bounty) "open") (err u3))
    (map-set Bounty id (merge bounty { status: "canceled" }))
    (ok true)))