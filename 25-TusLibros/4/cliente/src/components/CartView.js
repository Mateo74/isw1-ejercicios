class CartComponent extends React.Component {
  constructor(props) {
    super(props)
  }

	onClickBook() {
		console.log("Book clicled!")
	}

	onAddBookClicked() {
		console.log("Book added!")
	}
	
	onRemoveBookClicked() {
		console.log("Book removed!")
	}

  render() {
    const {
      router,
      cartID,
      classes,
    } = this.props

		let catalog = [
			{
				isbn: "isbn1",
				title: "A Book",
				author: "An Author",
				price: 45,
			},
			{
				isbn: "isbn2",
				title: "Another Book",
				author: "Another Author",
				price: 35,
			},
			{
				isbn: "isbn3",
				title: "Another Book 2",
				author: "Another Author 2",
				price: 38,
			}
		]
		
		let cartContent = {
			isbn1: 4,
			isbn2: 5,
		}
		
		let cartItems = catalog.map((item, index) => {
			let quantity = 0
			if (item.isbn in cartContent) {
				quantity = cartContent[item.isbn]
			}
			return {
				title: item.title,
				isbn: item.isbn,
				quantity: quantity,
			}
		})

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Books that are actually in your Cart:
				</Typography>
				<BookList
					bookList={cartItems.filter((item) => item.quantity > 0)}
					onClickBook={this.onClickBook}
					onClickAdd={this.onAddBookClicked}
					onClickSub={this.onRemoveBookClicked}
					quantityHeading="Quantity"
				/>
      </div>
    )
  }
}

// Add style
const CartView = withStyles(styles, {
  withTheme: true
})(CartComponent)
