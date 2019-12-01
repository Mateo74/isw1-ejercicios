class ClickableBookTitleComponent extends React.Component {
  constructor(props) {
    super(props)
  }
	
	onClickTitle() {
		const {isbn, router} = this.props
		router.navigate("/bookDetail", {displayedBookIsbn: isbn})
	}
	
	render() {
		return (
			<Button onClick={() => this.onClickTitle()}>{this.props.title}</Button>
		)
	}
}

const ClickableBookTitle = withStyles(styles, {
  withTheme: true
})(ClickableBookTitleComponent)
