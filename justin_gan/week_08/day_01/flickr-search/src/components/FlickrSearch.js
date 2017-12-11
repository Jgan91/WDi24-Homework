import React, { PureComponent } from 'react';

class FlickrSearch extends PureComponent {
  render() {
    return (
      <React.Fragment>
        <h1>FlickrSearch</h1>
        <SearchForm />
        <Gallery />
      </React.Fragment>
    );
  }
}

class SearchForm extends PureComponent {
  constructor() {
    super();
    this.state = { query: '' };
    this._handleClick = this._handleClick.bind( this );
    this._handleChange = this._handleChange.bind( this );
  }

  _handleClick(e) {
    e.preventDefault();
    console.log( 'submitted', this.state.query );
  }

  _handleChange(e) {
    this.setState( { query: e.target.value } );
  }

  render() {
    return (
      <form onSubmit={ this._handleClick }>
        <input type="search" placeholder="Some text..." onChange={ this._handleChange } />
        <input type="submit" value="Go" />
      </form>
    )
  }
}

class Gallery extends PureComponent {
  render() {
    return (
      <h2>Gallery coming soon</h2>
    )
  }
}

export default FlickrSearch;
