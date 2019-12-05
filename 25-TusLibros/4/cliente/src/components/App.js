class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      clientID: -1,
      clientPassword: "",
			cartID: -1,
      displayedBookIsbn: "",
      checkoutTicket: {},
      errorMessage: "",
    };
  }

  render() {
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        this.setState({ ...state, path: path })
      }
    }
		
		let title = "Tus Libros"
    let content = "Where am I?"
		let {
      path,
      clientID,
      clientPassword,
      cartID,
      displayedBookIsbn,
      checkoutTicket,
      errorMessage
    } = this.state
		
		if (cartID === -1) {
			path = "/"
		}

    if (path === "/") {
      content = (<CartCreationView
        router={router}
      />)
    }
    else if (path === "/catalog") {
      content = (<CatalogView
        router={router}
        cartID={cartID}
      />)
    }
    else if (path === "/cart") {
      content = (<CartView
        router={router}
        cartID={cartID}
        clientID={clientID}
      />)
    }
    else if (path === "/bookDetail") {
			content = (<BookDetailView
				router={router}
				cartID={cartID}
				isbn={displayedBookIsbn}
      />)
    }
    else if (path === "/purchaseHistory") {
      content = (<PurchaseHistoryView
        router={router}
        clientID={clientID}
        clientPassword={clientPassword}
      />)
    }
    else if (path === "/ticket") {
      content = (<TicketView router={router} ticket={checkoutTicket} />)
    }
    else if (path ==="/error") {
			content = (<ErrorView message={errorMessage} router={router} />)
		}
		
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
