class EditableBookQuantityComponent extends React.Component {
  constructor(props) {
    super(props)
		this.state = {quantity: props.initialQuantity}
  }
	
	makeRequestAndChangeQuantity(path, changeBy) {
		handleErrors(this.props.router, request(path)
			.then(responseBody => this.setState({quantity: this.state.quantity + changeBy}))
		)
	}
	
	onClickAdd() {
		const {cartID, isbn} = this.props
		this.makeRequestAndChangeQuantity(`addToCart?cartID=${cartID}&bookIsbn=${isbn}&quantity=1`, 1)
	}
	
	onClickRemove() {
		if (this.state.quantity > 0) {
			const {cartID, isbn} = this.props
			this.makeRequestAndChangeQuantity(`removeFromCart?cartID=${cartID}&bookIsbn=${isbn}`, -1)
		}
	}
	
	render() {
		return (
			<div>
				<Button onClick={() => this.onClickAdd()}>
					+
				</Button>
				
				{this.state.quantity}
				
				<Button onClick={() => this.onClickRemove()}>
					-
				</Button>
			</div>
		)
	}
}

const EditableBookQuantity = withStyles(styles, {
  withTheme: true
})(EditableBookQuantityComponent)
