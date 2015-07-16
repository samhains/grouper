var SearchResults = React.createClass({
  render(){
    var searchResults = this.props.videos.map(
      function(video){
        var newThing = video;
        return (
          <SearchResult video={newThing}/>  
        );
      });
    return (<div>
              <ul className="list-group">{searchResults}</ul>
            </div>
           );
  }
});
