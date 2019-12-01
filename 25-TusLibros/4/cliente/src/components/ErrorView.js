class ErrorComponent extends React.Component {
  constructor(props) {
    super(props)
  }

	onClickOk() {
		this.props.router.navigate("/", {cartID: -1})
	}

	render() {
		return (
			<div>
				<h1 style={{color:'red'}}>An error occurred:</h1>
				<div style={{color:'red'}}>{this.props.message}</div>
				<Button onClick={() => this.onClickOk()}>Ok</Button>
			</div>
		)
	}
}

const ErrorView = withStyles(styles, {
  withTheme: true
})(ErrorComponent)

