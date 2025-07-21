;; DAO for protocol governance
(define-constant proposal-duration u100)
(define-map Proposal
  id uint
  (creator principal, description (string-utf8 200),
  votes-for uint, votes-against uint, end-height uint))

(define-data-var next-proposal-id uint u0)

;; Create new proposal
(define-public (create-proposal (description (string-utf8 200)))
  (let ((id (var-get next-proposal-id)))
  (map-set Proposal id {
    creator: tx-sender,
    description: description,
    votes-for: u0,
    votes-against: u0,
    end-height: (+ block-height proposal-duration)
  })
  (var-set next-proposal-id (+ id u1))
  (ok id))