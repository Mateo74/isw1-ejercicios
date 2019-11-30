class EditableBookQuantityComponent extends React.Component {
  constructor(props) {
    super(props)
		
		this.state = {quantity: props.quantity}
  }
	
	onClickAdd() {
		this.setState({quantity: this.state.quantity + 1})
	}
	
	onClickRemove() {
		let quantity = this.state.quantity
		if (quantity > 0) {
			this.setState({quantity: quantity - 1})
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
