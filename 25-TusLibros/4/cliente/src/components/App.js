class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
			cartID: 0,
    };
  }

  render() {
    let title = "Tus Libros"
    let content = "Where am I?"
		
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        // http://es6-features.org/#SpreadOperator
        this.setState({ ...state, path: path })
      }
    }

    if (this.state.path === "/") {
      content = (<CartCreationView
        router={router}
      />)
    } else if (this.state.path === "/catalog") {
      content = (<CatalogView
        router={router}
        cartID={this.state.cartID}
      />)
    } else if (this.state.path === "/cart") {
      content = (<CartView
        router={router}
        cartID={this.state.cartID}
      />)
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
