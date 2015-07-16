
var SearchBox = React.createClass({
  handleInput(e){
    this.props.handleInput(this.refs.filterTextInput.getDOMNode().value);

  },
  render(){
    return (
      <div>
        <input 
          onChange={this.handleInput} 
          value={this.props.filterText}
          ref="filterTextInput"> 
        </input>
        <button>Search</button>
      </div>
      );
  }
});
