global.basedir = "#{__dirname}/../../src/"

global.doc = createSpyObj('doc', ['getElementById'])
doc.getElementById.andReturn(childNodes: [0,1,2,3,4, { innerHTML: ''}])
