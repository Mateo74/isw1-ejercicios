class EditableBookQuantityComponent extends React.Component {
  constructor(props) {
    super(props)
		this.state = {quantity: props.quantity}
  }
	
	onClickAdd() {
		const {cartID, isbn, quantity, router} = this.props
		handleErrors(router, request(`addToCart?cartID=${cartID}&bookIsbn=${isbn}&quantity=1`)
			.then((responseBody) => this.setState({quantity: this.state.quantity + 1}))
		)
	}
	
	onClickRemove() {
		
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
