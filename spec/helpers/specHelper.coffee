global.basedir = "#{__dirname}/../../lib/"

global.doc = createSpyObj('doc', ['getElementById'])
doc.getElementById.andReturn(childNodes: [0,1,2, { innerHTML: ''}])
