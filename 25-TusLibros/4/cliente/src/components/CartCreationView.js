class CartCreationComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
			clientID: "",
			password: "",
			error: false,
			errorMessage: "",
    }
  }

  handleClientIDChange(event) {
    this.setState({
      clientID: event.target.value
    })
  }
	
	handlePasswordChange(event) {
    this.setState({
			password: event.target.value
    })
	}

  handleCreate() {
    const {clientID, password} = this.state
    request(`createCart?clientID=${clientID}&password=${password}`)
      .then((responseBody) => this.props.router.navigate("/catalog", {cartID: responseBody, clientID: clientID, clientPassword: password}))
      .catch((error) => this.setState({error: true, errorMessage: error.message}));
  }

	errorMessageElement() {
		const {error, errorMessage} = this.state
		if (error) {
			return <div style={{color:'red'}}>{errorMessage}</div>
		}
		return null
	}

  render() {
    const {clientID, password} = this.state

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Enter your Client ID and password
         </Typography>
        <InputField
					label="Client ID"
					value={clientID}
					onChange={(e) => this.handleClientIDChange(e)}
				/>
				<InputField
					label="Password"
					value={password}
					onChange={(e) => this.handlePasswordChange(e)}
				/>
				{this.errorMessageElement()}
        <Button
          color="inherit"
          onClick={(e) => this.handleCreate()}>
					Log In and create a Cart
				</Button>
      </div>
    )
  }
}

// Add style
const CartCreationView = withStyles(styles, {
  withTheme: true
})(CartCreationComponent)
