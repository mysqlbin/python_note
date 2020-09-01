<template>
   <p>
       {{text}}
    </p> 
</template>

<script>
export default {
    name: "TodoItem",
    props: {
        "text": {
            default: 'no content',
            type: String
        }
    }
}
</script>