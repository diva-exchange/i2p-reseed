module i2pgit.org/idk/reseed-tools/src/i2p-tools

go 1.16

require (
	github.com/diva-exchange/i2p-reseed v0.0.0-00010101000000-000000000000
	github.com/gorilla/handlers v1.5.1
	github.com/justinas/alice v1.2.0
	github.com/urfave/cli v1.22.15
)

//replace github.com/go-i2p/go-i2p => ../../../github.com/go-i2p/go-i2p

replace github.com/diva-exchange/i2p-reseed => .
