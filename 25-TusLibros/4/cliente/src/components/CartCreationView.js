class CartCreationComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
			clientID: "",
			password: "",
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
    getLocalAsJson(`createCart?clientID=${clientID}&password=${password}`)
      .then((response) => response.json())
      .then((json) => this.props.router.navigate("/catalog", {cartID: json.response}))
      .catch((error) => console.log('Looks like there was a problem: \n', error));
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
        <Button
          color="inherit"
          onClick={(e) => this.handleCreate(e)}>
					Create Cart
				</Button>
      </div>
    )
  }
}

// Add style
const CartCreationView = withStyles(styles, {
  withTheme: true
})(CartCreationComponent)
