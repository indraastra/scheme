#lang scheme

(require net/url)
(require srfi/13)

;;; FLAGS
(define *flag-table*
  #hash((a  . "Ask")
        (a2 . "Average Daily Volume")
        (a5 . "Ask Size")
        (b  . "Bid")
        (b2 . "Ask (Real-time)")
        (b3 . "Bid (Real-time)")
        (b4 . "Book Value")
        (b6 . "Bid Size")
        (c  . "Change & Percent Change")
        (c1 . "Change")
        (c3 . "Commission")
        (c6 . "Change (Real-time)")
        (c8 . "After Hours Change (Real-time)")
        (d  . "Dividend/Share")
        (d1 . "Last Trade Date")
        (d2 . "Trade Date")
        (e  . "Earnings/Share")
        (e1 . "Error Indication (returned for symbol changed / invalid)")
        (e7 . "EPS Estimate Current Year")
        (e8 . "EPS Estimate Next Year")
        (e9 . "EPS Estimate Next Quarter")
        (f6 . "Float Shares")
        (g  . "Day's Low")
        (h  . "Day's High")
        (j  . "52-week Low")
        (k  . "52-week High")
        (g1 . "Holdings Gain Percent")
        (g3 . "Annualized Gain")
        (g4 . "Holdings Gain")
        (g5 . "Holdings Gain Percent (Real-time)")
        (g6 . "Holdings Gain (Real-time)")
        (i  . "More Info")
        (i5 . "Order Book (Real-time)")
        (j1 . "Market Capitalization")
        (j3 . "Market Cap (Real-time)")
        (j4 . "EBITDA")
        (j5 . "Change From 52-week Low")
        (j6 . "Percent Change From 52-week Low")
        (k1 . "Last Trade (Real-time) With Time")
        (k2 . "Change Percent (Real-time)")
        (k3 . "Last Trade Size")
        (k4 . "Change From 52-week High")
        (k5 . "Percebt Change From 52-week High")
        (l  . "Last Trade (With Time)")
        (l1 . "Last Trade (Price Only)")
        (l2 . "High Limit l3 Low Limit")
        (m  . "Day's Range")
        (m2 . "Day's Range (Real-time)")
        (m3 . "50-day Moving Average")
        (m4 . "200-day Moving Average")
        (m5 . "Change From 200-day Moving Average")
        (m6 . "Percent Change From 200-day Moving Average")
        (m7 . "Change From 50-day Moving Average")
        (m8 . "Percent Change From 50-day Moving Average")
        (n  . "Name n4 Notes")
        (o  . "Open")
        (p  . "Previous Close")
        (p1 . "Price Paid")
        (p2 . "Change in Percent")
        (p5 . "Price/Sales")
        (p6 . "Price/Book")
        (q  . "Ex-Dividend Date")
        (r  . "P/E Ratio")
        (r1 . "Dividend Pay Date")
        (r2 . "P/E Ratio (Real-time)")
        (r5 . "PEG Ratio")
        (r6 . "Price/EPS Estimate Current Year")
        (r7 . "Price/EPS Estimate Next Year")
        (s  . "Symbol")
        (s1 . "Shares Owned")
        (s7 . "Short Ratio")
        (t1 . "Last Trade Time")
        (t6 . "Trade Links")
        (t7 . "Ticker Trend")
        (t8 . "1 yr Target Price")
        (v  . "Volume")
        (v1 . "Holdings Value")
        (v7 . "Holdings Value (Real-time)")
        (w  . "52-week Range")
        (w1 . "Day's Value Change")
        (w4 . "Day's Value Change (Real-time)")
        (x  . "Stock Exchange")
        (y  . "Dividend Yield")))

(define (get-flag-help flag)
  (hash-ref *flag-table* flag))

(define (format-flag-help flag description)
  (format "~a : ~a\n" flag description))

(define (display-flag-help flag)
  (display (format-flag-help flag (get-flag-help flag))))

(define (display-flags)
  (map display
       (hash-map *flag-table* format-flag-help))
  (void))

;;; LOOKUP
(define *url-prefix* "http://download.finance.yahoo.com/d/quotes.csv")

(define (generate-url ticker-symbol flags)
  (let* ([joined-flags (string-join (map symbol->string flags) "")]
         [symbol-query (string-append "?s=" (symbol->string ticker-symbol))]
         [flag-query (string-append "&f=" joined-flags)])
  (string-append *url-prefix*
                 symbol-query
                 flag-query)))

(define (fetch-quote ticker-symbol flags)
  (let* ([url (generate-url ticker-symbol flags)]
         [p (get-pure-port (string->url url))]
         [line (string-trim-right (read-line p))])
    (close-input-port p)
    line))

(define (display-quote ticker-symbol flags data)
  (let ([clean-data (map strip-quotes (split-comma data))])
    (display (format "+~a+" ticker-symbol))
    (newline)
    (map (lambda (flag datum)
           (display (format "~a : ~a" (get-flag-help flag) datum))
           (newline))
         flags
         clean-data))
  (void))

(define (lookup-quote ticker-symbol 
                [flags '(t1 l1)])
  (let ([quote-data (fetch-quote ticker-symbol flags)])
    (display-quote ticker-symbol
                   flags
                   quote-data)))

;;; HELPER
(define (strip-quotes string)
  (string-trim-both string #\"))

(define (split-comma string)
  (regexp-split #rx"," string))