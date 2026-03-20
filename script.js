// 1. I-initialize ang Supabase
const supabaseUrl = 'https://cvxecyiedhoeasnvtxac.supabase.co'
const supabaseKey = 'sb_publishable_ofPKCEMkhcEfvwU7GiQA1A_4LuaRA6l'
const supabase = supabase.createClient(supabaseUrl, supabaseKey)

// 2. Makinig sa Contact Form Submission
const contactForm = document.getElementById('contactForm');

if (contactForm) {
    contactForm.addEventListener('submit', async (e) => {
        e.preventDefault(); // Iwasan ang pag-refresh ng page

        // Kunin ang data mula sa form
        const name = document.getElementById('contactName').value;
        const email = document.getElementById('contactEmail').value;
        const message = document.getElementById('contactMessage').value;

        // I-save ang message sa Supabase table na 'Contacts'
        const { data, error } = await supabase
            .from('Contacts')
            .insert([{ name, email, message }]);

        if (error) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Hindi naisend ang message: ' + error.message,
            });
        } else {
            Swal.fire({
                icon: 'success',
                title: 'Message Sent!',
                text: 'Salamat sa pag-contact sa Charide!',
                confirmButtonColor: '#28a745'
            });
            contactForm.reset(); // Linisin ang form
        }
    });
}




