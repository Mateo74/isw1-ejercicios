class BookDetailComponent extends React.Component {
  constructor(props) {
    super(props)
		
		this.state = {title: "", author: "", quantity: null}
  }
	
	componentDidMount() {
		const {cartID, isbn, router} = this.props
		let title = ""
		let author = ""
		
		handleErrors(router, request(`catalog`)
			.then((catalog) => {
				title = catalog[isbn].title
				author = catalog[isbn].author
			})
		)
		
		handleErrors(router, request(`listCart?cartID=${cartID}`)
			.then((cartContent) => {
				let quantity = 0
				if (isbn in cartContent) {
					quantity = cartContent[isbn]
				}
				this.setState({title: title, author: author, quantity: quantity})
			})
		)
	}
	
	render() {
		const {cartID, isbn, router} = this.props
		const {title, author, quantity} = this.state
		
		return (
			<div>
				<h1>{title}</h1>
				<div>Author: {author}</div>
				<div>ISBN: {isbn}</div>
				<div>Quantity In Cart:</div>
				{quantity != null && <EditableBookQuantity cartID={cartID} isbn={isbn} quantity={quantity} router={router} />}
			</div>
		)
	}
}

const BookDetailView = withStyles(styles, {
  withTheme: true
})(BookDetailComponent)
