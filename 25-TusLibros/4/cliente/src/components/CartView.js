class CartComponent extends React.Component {
  constructor(props) {
    super(props)
  }

	onCheckoutClicked() {
    const {cartID, router} = this.props
    handleErrors(router, request(`checkoutCartWithDefaultCard?cartID=${cartID}`)
      .then(ticket => {
        router.navigate('/ticket', {checkoutTicket: ticket})
      })
    )
	}

  render() {
    const {cartID, router} = this.props
		
    return (
      <div>
        <Typography component="h1" gutterBottom>
          Books that are actually in your Cart:
				</Typography>
				<BookList
					cartID={cartID}
					quantityHeading="Quantity"
					router={router}
				/>
				<Button onClick={() => this.onCheckoutClicked()}>Checkout</Button>
      </div>
    )
  }
}

// Add style
const CartView = withStyles(styles, {
  withTheme: true
})(CartComponent)
