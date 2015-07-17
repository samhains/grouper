var SearchResults = React.createClass({
  render(){
    var searchResults = this.props.users.map(
      function(user){
        var newThing = user;
        return (
          <SearchResult user={newThing}/>  
        );
      });
    return (<div>
              <ul className="list-group">{searchResults}</ul>
            </div>
           );
  }
});
