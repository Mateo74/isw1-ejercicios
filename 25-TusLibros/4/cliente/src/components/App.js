class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
			cartID: -1,
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
		let {path, cartID, errorMessage} = this.state
		
		if (cartID === -1) {
			path = "/"
		}

    if (path === "/") {
      content = (<CartCreationView
        router={router}
      />)
    } else if (path === "/catalog") {
      content = (<CatalogView
        router={router}
        cartID={this.state.cartID}
      />)
    } else if (path === "/cart") {
      content = (<CartView
        router={router}
        cartID={this.state.cartID}
      />)
    } else if (path ==="/error") {
			content = (<ErrorView message={this.state.errorMessage} router={router} />)
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
