class CartCreationComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
			clientID: "",
			password: "",
    }
  }

  handleClientIDChange(event) {
		const {clientID, password} = this.state
    this.setState({
      clientID: event.target.value,
			password: password
    })
  }
	
	handlePasswordChange(event) {
		const {clientID, password} = this.state
    this.setState({
      clientID: clientID,
			password: event.target.value
    })
	}

  handleCreate() {
    const {
      router,
    } = this.props

    const {
			clientID,
      password,
    } = this.state

    getLocalAsJson(`createCart?clientID=${clientID}&password=${password}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
				console.log(`cart ID = ${json.response}`)
        router.navigate("/catalog", { cartID: json.response })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  render() {
    const {clientID, password} = this.state

    const {
      classes,
    } = this.props

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Enter your Client ID and password
         </Typography>
        <FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">Client ID</InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={clientID}
            onChange={(ev)=>this.handleClientIDChange(ev)}
            startAdornment={<InputAdornment position="start">></InputAdornment>}
            labelWidth={60}
            multiline
            rows="1"
          />
        </FormControl>
				<FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">Password</InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={password}
            onChange={(ev)=>this.handlePasswordChange(ev)}
            startAdornment={<InputAdornment position="start">></InputAdornment>}
            labelWidth={60}
            multiline
            rows="1"
          />
        </FormControl>

        <Button
          color="inherit"
          onClick={(ev)=>this.handleCreate(ev)}>
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
